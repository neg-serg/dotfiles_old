-- Copyright Sankell Software 2011

module TinyLaunchbury (
                  Expr(Lambda, Apply, Var, Let, Prim, Ctor, Case),
                  reduce,
                  displayReduce) where

import Data.List(foldl',intercalate)
import Control.Monad.State
import Control.Monad.Error
import Control.Monad.Identity
import Control.Arrow( second, (***) )
import Data.Monoid


type Name = String 

data Expr =  Lambda Name Expr
           | Apply Expr Name
           | Var Name
           | Let Bindings Expr
           | Prim Name Expr Expr
           | Ctor Int [Name]
           | Case Expr Alts
           deriving Eq

type Binding = (Name,Expr)
type Bindings = [Binding]
type Alt = (Int, ([Name], Expr) )
type Alts = [Alt]

-- |Gets the list of variable names from the bindings
binders :: Bindings -> [Name]
binders = map fst

-- | Displays an Expression using a more common lambda calculus syntax
-- rather than just printing the syntax tree.
instance Show Expr where
  show (Lambda x e) = "\\" ++ x ++ "." ++ show e
  show (Apply e x) = show e ++ " " ++ x
  show (Var x) = x
  show (Let bindings e) = "let " ++ bindingStr ++ " in " ++ show e 
       where showBinding (x,e') = x ++ " = " ++ show e'
             bindingStr = intercalate ", " (map showBinding bindings)
  show (Prim fun e e') = show e ++ " " ++ fun ++ " " ++ show e'
  show (Ctor ctor []) = show ctor
  show (Ctor ctor args) = "<" ++ show ctor ++ " " ++ unwords args ++">"
  show (Case e alts) = "case " ++ show e ++ " of " ++ caseStr 
         where dispCase (ctor, (args, e')) = show (Ctor ctor args) 
                                                  ++ " -> " ++ show e'
               caseStr = (intercalate ", " . map dispCase) alts

type Heap = [(Name, Expr)]

-- | Remove some binding from the heap.
hRemoveBinding :: Name -> (Heap -> Heap)
hRemoveBinding x = filter $ (/= x) . fst


type StateErrorT s a m = ErrorT String (StateT s m) a
runStateErrorT = runStateT. runErrorT 

type StateError s a = StateErrorT s a Identity
runStateError m = runIdentity. runStateErrorT m

data ReduceState = RS { rsHeap :: Heap
                      , rsFreshVars :: [Name]
                      , rsLogIndentation :: Int
                      , rsLog :: Log
                      }

rsInitial :: ReduceState
rsInitial = RS { rsHeap = []
               , rsFreshVars = freshVarNames
               , rsLogIndentation = 0
               , rsLog = []
               }

type ReduceM a =  StateError ReduceState a
rmRun :: ReduceM a -> ReduceState-> (Either String a, ReduceState)
rmRun = runStateError

-- hides the implementation detail of fail vs throw error; makes it easier to
-- swap out the underlying monad.
rmErr :: String -> ReduceM Expr
rmErr e = do appendToLog $ "Error: " ++ e
             h  <- fmap rsHeap get
             appendToLog (show h)
             throwError e

-- |Like sub, but for a list of things to substite
-- usefull for implementing recursive lets (i.e. letrec)
subs :: [(Name,Name)] -> (Expr -> Expr)
subs = foldr (.) id . map (uncurry sub)

-- |e[x/y] in Launchbury's notation
--  [x ↦ y]e in Pierce's notation in TaPL
--  recursively descend expression tree to substitute a free variable
sub ::  Name -> Name -> (Expr -> Expr)
sub x y e =
 let subExpr = sub x y
     subName z | x == z    = y
               | otherwise = z
     -- subAlt (ctor, (args, e'')) = (ctor, (map subName args, subExpr e''))
     subAlt = second (map subName *** subExpr)
 in case e of
       Lambda z e'| z == x              -> e -- only want to sub free variables;
                                             -- x is no longer free
                  | otherwise           -> Lambda z (subExpr e')
       Apply e' z                       -> Apply (subExpr e') (subName z)
       Var z                            -> Var (subName z)
       Let bs e'  | elem x (binders bs) -> e -- only want to sub free variables;
                                             -- x is no longer free
                  | otherwise           -> Let bs (subExpr e')
       Prim fun e' e''                  -> Prim fun (subExpr e') (subExpr e'')
                                        -- substitute the variables in the ctor;
                                        -- the ctor itself should be left alone 
       Ctor ctor args                   -> Ctor ctor (map subName args)
       Case e' alts                     -> Case (subExpr e') (map subAlt alts) 

-- helper function fro freshen; freshens an alternative in a case statement
freshenAlt :: Alt -> ReduceM Alt
freshenAlt (ctr, (ns,e)) = do e' <- freshen e
                              return (ctr, (ns, e'))

-- |freshen takes an expression, and returns the same expression with every 
-- bound variable substituted for a fresh variable. 
freshen :: Expr -> ReduceM Expr
freshen l@(Lambda x e)     = do y <- getFreshVar
                                e' <- (freshen . sub x y) e
                                return $ Lambda y e'
freshen (Apply e x)        = do e' <- freshen e 
                                return $ Apply e' x
freshen v@(Var _)          = return v
freshen l@(Let bs e)       = do let vs = map fst bs 
                                    es = map snd bs
                                vs' <- getFreshVars (length bs)
                                -- let is mutually recursive, so any binding
                                -- can refer to any other binding
                                let subFreshF = freshen . subs (zip vs vs')
                                es' <- mapM subFreshF es
                                e' <- subFreshF e
                                return $ Let (zip vs' es') e'
freshen (Prim fun e e')    = liftM2 (Prim fun) (freshen e) (freshen e') 
                           -- if the constructor's args needed to be freshened
                           -- they already were
freshen c@(Ctor ctor args) = return c
freshen (Case e alts)      = liftM2 Case (freshen e) (mapM freshenAlt alts)

type ErrorOr a = Either String a
type Log = String

appendToLog :: String -> ReduceM ()
appendToLog msg = modify $ \s ->  s {rsLog = rsLog s ++ "\n" 
                                          ++ (replicate (rsLogIndentation s) '|'
                                          ++ msg)}
-- | returns whatever x is bound to in the heap, or calls rmErr if it isn't in
-- the heap
heapLookup :: Name -> ReduceM Expr
heapLookup x = do me <- fmap (lookup x . rsHeap) get
                  -- return the error if me is nothing; return me otherwise
                  maybe (rmErr $ "Illigal free variable: " ++ x 
                               ++ " isn't in the heap.") return me

heapModify ::  (Heap -> Heap) -> ReduceM ()
heapModify f = modify $ \s -> s { rsHeap = f (rsHeap s) }

-- | Removes a binding from the heap.
heapRemove :: Name -> ReduceM ()
heapRemove x = heapModify (hRemoveBinding x)

-- | Adds a binding to the heap
heapAdd :: Name -> Expr -> ReduceM ()
heapAdd x e = heapModify ((x,e):)

getFreshVar :: ReduceM Name
getFreshVar = do (v:vs) <- fmap rsFreshVars get
                 modify (\s -> s {rsFreshVars = vs})
                 return v

getFreshVars :: Int -> ReduceM [Name]
getFreshVars = sequence . flip replicate getFreshVar

withLogIndent :: ReduceM b -> ReduceM b
withLogIndent funarg = do s@(RS _ _ i _) <- get
                          put $ s {rsLogIndentation = i+1}
                          result <- funarg
                          s' <- get
                          put $ s' {rsLogIndentation = i}
                          return result 

realReduce :: Expr -> ReduceM ()
realReduce e = do e' <- reduceM e
                  appendToLog $ "Ans: " ++ show e'


evalAndGetLog :: ReduceM a -> String
evalAndGetLog = rsLog . snd . flip rmRun rsInitial

evalAndGetExpr :: Expr -> Either String Expr
evalAndGetExpr = fst . flip rmRun rsInitial . reduceM

-- |Reduces an expression, and returns a string containing the log appended with
-- the result
reduce :: Expr -> String
reduce =  evalAndGetLog . realReduce

-- | Prints the result of reduce to stdout.  The main reason for this function
--  is that the log contains newline Chars, and newlines don't format correctly
--  in ghci.
displayReduce :: Expr -> IO ()
displayReduce = putStrLn . reduce


freshVarNames :: [Name]
freshVarNames = ["$" ++ show x | x <- [1..]]

showHeap h = "{" ++ heapStr ++ "}" 
  where showElem (x, e) = x ++ " -> " ++ show e
        heapStr = intercalate ", " $ map showElem h



-- |Performs long-step reduction of an expression, logging the steps taken along the way.
reduceM :: Expr -> ReduceM Expr
reduceM e = let logCase msg = do s <- get
                                 appendToLog $ msg ++ show e
                                             ++ " : " ++  showHeap (rsHeap s) 
 in case e of
        Lambda e' x ->  logCase "Returning lambda: " >> return (Lambda e' x)  
        Apply e' x  -> do logCase "Reducing apply: "
                          Lambda y' e'' <- withLogIndent $ reduceM e'
                          withLogIndent $ reduceM (sub y' x e'')
        Var x ->      do logCase "Reducing variable: " 
                         e' <- heapLookup x
                         heapRemove x
                         z <- withLogIndent $ reduceM e'
                         appendToLog $ "Rebinding var " ++ x ++ " to " ++ show z
                         heapAdd x z
                         freshen z
        Let bs e' -> do logCase "Reducing let: "
                        mapM_ (uncurry heapAdd) bs
                        withLogIndent $ reduceM e'
        Prim fun e1 e2 -> do  logCase "Reducing primitive: " 
                              n1 <- withLogIndent $ reduceM e1
                              n2 <- withLogIndent $ reduceM e2
                              result <- executePrimitive fun n1 n2  
                              appendToLog $ "Primitive evaluated to " 
                                            ++ show result
                              return result 
        Ctor ctor args -> do logCase "Returning constructor: " 
                             return $ Ctor ctor args
        Case e' alts  -> 
          do logCase "Reducing case statement: " 
             e''@(Ctor ctor args) <- withLogIndent $ reduceM e'
             case lookup ctor alts of
                Just (altNs, altE) -> withLogIndent $ reduceM $ subs (zip altNs args) altE
                Nothing -> rmErr $ "non-exhaustive patterns in case " ++ show e
                                ++ "; no match for constructor " ++ show e''
   
executePrimitive :: Name -> Expr -> Expr -> ReduceM Expr
executePrimitive f (Ctor n1 []) (Ctor n2 []) = 
  let fReal = lookup f [("+",(+))
                        ,("-",(-))
                        ,("/",(div))
                        ,("*",(*))]
  in case fReal of 
      Just fun -> return $ Ctor (fun n1 n2) []
      Nothing -> rmErr $ "primitive " ++ f  
                       ++ " doesn't exist for nullary constructors"
executePrimitive f e e' = rmErr $ "e = " ++ show e ++ " e' = " ++ show e'

-- Some example expressions, plus some functions to make constructing 
-- expressions easier
mkNum x = Ctor x []

addExpr  = Prim "+" 
multExpr = Prim "*" 

add x y = addExpr (mkNum x) (mkNum y)
addVar x y = addExpr (Var x) (mkNum y)
addVars x y = addExpr (Var x) (Var y)
multVars x y = multExpr (Var x) (Var y)
applyVars x y = Apply (Var x) y

simpleExpr = Let [("u", add 3 2),
                  ("v", addVar "u" 1)]
                 $ addVars "v" "v"

-- Recursive, but refers to x before x is put back on the heap.
-- will very quickly fail.
errorExpr = Let [("x", Var "x")] (Var "x")

fastExpr  = Let [("u", add 2 3),
                 ("f", Let [("v", addVar "u" 1)]
                           (Lambda "x" (addVars "v" "x"))),
                 ("a", mkNum 2),
                 ("b", mkNum 3)]
                $ addExpr (applyVars "f" "a") (applyVars "f" "b")


                
slowExpr = Let [("u", add 2 3),
                 ("f", (Lambda "x"
                               (Let [("v", addVar "u" 1)]
                                    (addVars "v" "x")))),
                 ("a", mkNum 2),
                 ("b", mkNum 3)]
                 $ addExpr (applyVars "f" "a") (applyVars "f" "b") 
            
slowExprHaskell = let u = 3+5
                      f = let v = u+1 in \x -> v + x
                  in f 2 + f 3

-- f reduces to \x.f x and is replaced onto the heap before
-- we apply x to it.  
infinteLoopExpr = Let [("f", Lambda "x" (applyVars "f" "x")),
                       ("a", mkNum 2)]
                  $ applyVars "f" "a" 



nestedExpr = let applyAdd var expr = Apply (Apply expr "add") var 
             in Let [("add", Lambda "x" $ Lambda "y" (addVars "x" "y"))
                 ,("a", mkNum 1)
                 ,("addA", applyVars "add" "a")
                 ,("b", mkNum 2)
                 ,("addB", applyVars "add" "b")
                 ,("applyAToB", applyVars "addA" "addB")
                 ,("c", mkNum 3)
                 ,("addC", applyVars "add" "c")
                 ,("applyCToAB", applyVars "applyAToB" "addC")
                 ,("d", mkNum 4)
                 ]
                 $ applyVars "applyCToAB" "d"
