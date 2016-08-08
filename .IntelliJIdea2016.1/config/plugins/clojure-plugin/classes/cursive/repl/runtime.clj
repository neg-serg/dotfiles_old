(ns cursive.repl.runtime
  (:import [java.lang.reflect Method Field Constructor]
           (clojure.lang DynamicClassLoader RT))
  (:require [clojure.reflect :as reflect]
            [clojure.set :as set]))

(def mappings {:macro    identity
               :ns       (comp name ns-name)
               :name     name
               :arglists #(mapv str %)
               :doc      identity
               :line     identity
               :file     identity
               :private  identity})

(defn mapped-metadata [v]
  (let [metadata (meta v)]
    (into {} (for [[key mapping] mappings]
               (if (contains? metadata key)
                 [key (mapping (get metadata key))])))))

(defn symbol-details [sym]
  (if-let [var (resolve sym)]
    (mapped-metadata var)))

(defn ns-symbols-by-name [ns-name]
  (if-let [the-ns (find-ns ns-name)]
    (->> (vals (ns-interns the-ns))
         (filter var?)
         (mapv mapped-metadata))))

(defn completions [ns]
  (if-let [ns (find-ns ns)]
    {:imports    (into {} (for [[sym ^Class class] (ns-imports ns)]
                            [(name sym) (.getName class)]))
     :symbols    (into {} (for [[k v] (ns-map ns) :when (var? v)]
                            [(name k) (mapped-metadata v)]))
     :namespaces (set (map (comp name ns-name) (all-ns)))
     :aliases    (into {} (for [[alias fqn] (ns-aliases ns)]
                            [(str alias) (str fqn)]))}
    {}))

(defn class-exists? [fqn]
  (try
    (Class/forName fqn false (.getContextClassLoader (Thread/currentThread)))
    true
    (catch Throwable _
      false)))

; Code from clojure.reflect modified to return strings instead of symbols,
; and to use getFields/Methods/Constructors instead of getDeclared forms
(def parse-flags #'reflect/parse-flags)

(defn constructor->map [^Constructor constructor]
  {:name            (.getName constructor)
   :declaring-class (reflect/typename (.getDeclaringClass constructor))
   :parameter-types (mapv reflect/typename (.getParameterTypes constructor))
   :exception-types (mapv reflect/typename (.getExceptionTypes constructor))
   :flags           (parse-flags (.getModifiers constructor) :constructor)}
  )

(defn method->map [^Method method]
  {:name            (.getName method)
   :return-type     (reflect/typename (.getReturnType method))
   :declaring-class (reflect/typename (.getDeclaringClass method))
   :parameter-types (mapv reflect/typename (.getParameterTypes method))
   :exception-types (mapv reflect/typename (.getExceptionTypes method))
   :flags           (parse-flags (.getModifiers method) :method)})

(defn field->map [^Field field]
  {:name            (.getName field)
   :type            (reflect/typename (.getType field))
   :declaring-class (reflect/typename (.getDeclaringClass field))
   :flags           (parse-flags (.getModifiers field) :field)})

(defn class-defs [fqns]
  (into {} (for [fqn fqns]
             (try
               [fqn (let [cls (Class/forName fqn)]
                      {:bases   (not-empty (set (map #'reflect/typename (bases cls))))
                       :flags   (parse-flags (.getModifiers cls) :class)
                       :members (set/union (set (map field->map (.getFields cls)))
                                           (set (map method->map (.getMethods cls)))
                                           (set (map constructor->map (.getConstructors cls))))})]
               (catch Throwable _
                 nil)))))

(or (RT/loadClassForName "cursive.riddley.Util")
    ;; Hex-encoded bytes of cursive.riddley.Util
    ;; xxd -p target/classes/cursive/riddley/Util.class
    (let [util-class-bytes (str "cafebabe0000003200350a0007001e07002009002100220a001f00230a00"
                                "0200240700250700260100063c696e69743e010003282956010004436f64"
                                "6501000f4c696e654e756d6265725461626c650100124c6f63616c566172"
                                "6961626c655461626c65010004746869730100164c637572736976652f72"
                                "6964646c65792f5574696c3b01000c6c6f63616c42696e64696e6701000c"
                                "4c6f63616c42696e64696e6701000c496e6e6572436c6173736573010063"
                                "28494c636c6f6a7572652f6c616e672f53796d626f6c3b4c636c6f6a7572"
                                "652f6c616e672f53796d626f6c3b4c6a6176612f6c616e672f4f626a6563"
                                "743b294c636c6f6a7572652f6c616e672f436f6d70696c6572244c6f6361"
                                "6c42696e64696e673b0100036e756d0100014901000373796d0100154c63"
                                "6c6f6a7572652f6c616e672f53796d626f6c3b010003746167010004666f"
                                "726d0100124c6a6176612f6c616e672f4f626a6563743b01000d6c6f6361"
                                "6c417267756d656e7401005128494c636c6f6a7572652f6c616e672f5379"
                                "6d626f6c3b4c636c6f6a7572652f6c616e672f53796d626f6c3b294c636c"
                                "6f6a7572652f6c616e672f436f6d70696c6572244c6f63616c42696e6469"
                                "6e673b01000a536f7572636546696c650100095574696c2e6a6176610c00"
                                "080009070027010022636c6f6a7572652f6c616e672f436f6d70696c6572"
                                "244c6f63616c42696e64696e670700280c002a002b0c002c002f0c000800"
                                "32010014637572736976652f726964646c65792f5574696c0100106a6176"
                                "612f6c616e672f4f626a656374010015636c6f6a7572652f6c616e672f43"
                                "6f6d70696c6572010017636c6f6a7572652f6c616e672f436f6d70696c65"
                                "7224430100014301000a45585052455353494f4e0100194c636c6f6a7572"
                                "652f6c616e672f436f6d70696c657224433b010007616e616c797a650700"
                                "3301000445787072010049284c636c6f6a7572652f6c616e672f436f6d70"
                                "696c657224433b4c6a6176612f6c616e672f4f626a6563743b294c636c6f"
                                "6a7572652f6c616e672f436f6d70696c657224457870723b070034010008"
                                "506174684e6f646501006b28494c636c6f6a7572652f6c616e672f53796d"
                                "626f6c3b4c636c6f6a7572652f6c616e672f53796d626f6c3b4c636c6f6a"
                                "7572652f6c616e672f436f6d70696c657224457870723b5a4c636c6f6a75"
                                "72652f6c616e672f436f6d70696c657224506174684e6f64653b29560100"
                                "1a636c6f6a7572652f6c616e672f436f6d70696c6572244578707201001e"
                                "636c6f6a7572652f6c616e672f436f6d70696c657224506174684e6f6465"
                                "0021000600070000000000030001000800090001000a0000002f00010001"
                                "000000052ab70001b100000002000b00000006000100000006000c000000"
                                "0c000100000005000d000e00000009000f00120001000a0000005c000800"
                                "0400000014bb0002591a2b2cb200032db800040301b70005b00000000200"
                                "0b00000006000100000009000c0000002a00040000001400130014000000"
                                "000014001500160001000000140017001600020000001400180019000300"
                                "09001a001b0001000a0000004c000800030000000ebb0002591a2b2c0104"
                                "01b70005b000000002000b0000000600010000000d000c00000020000300"
                                "00000e0013001400000000000e0015001600010000000e00170016000200"
                                "02001c00000002001d00110000002200040002001f001000090021001f00"
                                "294019002d001f002e06080030001f00310008")
          unhexify (fn [c1 c2]
                     (unchecked-byte
                       (+ (bit-shift-left (Character/digit (char c1) 16) 4)
                          (Character/digit (char c2) 16))))
          bytecode (byte-array (map #(apply unhexify %) (partition 2 util-class-bytes)))]
      (.defineClass ^DynamicClassLoader @Compiler/LOADER "cursive.riddley.Util" bytecode nil)))

(ns cursive.riddley.compiler
  (:import
    [clojure.lang
    Var
    Compiler
    Compiler$ObjMethod
    Compiler$ObjExpr]
    [cursive.riddley Util]))

(defn- stub-method []
  (proxy [Compiler$ObjMethod] [(Compiler$ObjExpr. nil) nil]))

(defn tag-of
  "Returns a symbol representing the tagged class of the symbol, or `nil` if none exists."
  [x]
  (when-let [tag (-> x meta :tag)]
    (let [sym (symbol
                (if (instance? Class tag)
                  (.getName ^Class tag)
                  (name tag)))]
      (when-not (= 'Object sym)
        sym))))

(let [n (atom 0)]
  (defn- local-id []
    (swap! n inc)))

(defn locals
  "Returns the local binding map, equivalent to the value of `&env`."
  []
  (when (.isBound Compiler/LOCAL_ENV)
    @Compiler/LOCAL_ENV))

(defmacro with-base-env [& body]
  `(binding [*warn-on-reflection* false]
     (with-bindings (if (locals)
                      {}
                      {Compiler/LOCAL_ENV {}})
       ~@body)))

(defmacro with-lexical-scoping
  "Defines a lexical scope where new locals may be registered."
  [& body]
  `(with-bindings {Compiler/LOCAL_ENV (locals)}
     ~@body))

(defmacro with-stub-vars [& body]
  `(with-bindings {Compiler/CLEAR_SITES nil
                   Compiler/METHOD      (stub-method)}
     ~@body))

;; if we don't do this in Java, the checkcasts emitted by Clojure cause an
;; IllegalAccessError on Compiler$Expr.  Whee.
(defn register-local
  "Registers a locally bound variable `v`, which is being set to form `x`."
  [v x]
  (with-stub-vars
    (.set ^Var Compiler/LOCAL_ENV

          ;; we want to allow metadata on the symbols to persist, so remove old symbols first
          (-> (locals)
              (dissoc v)
              (assoc v (try
                         (Util/localBinding (local-id) v (tag-of v) x)
                         (catch Exception _
                           ::analyze-failure)))))))

(defn register-arg
  "Registers a function argument `x`."
  [x]
  (with-stub-vars
    (.set ^Var Compiler/LOCAL_ENV
          (-> (locals)
              (dissoc x)
              (assoc x (Util/localArgument (local-id) x (tag-of x)))))))

(ns cursive.riddley
  (:refer-clojure :exclude [macroexpand])
  (:require
    [cursive.riddley.compiler :as cmp])
  (:import (clojure.lang IObj)))

(defn- walkable? [x]
  (and
    (sequential? x)
    (not (vector? x))
    (not (instance? java.util.Map$Entry x))))

(defn macroexpand
  "Expands both macros and inline functions. Optionally takes a `special-form?` predicate which
   identifies first elements of expressions that shouldn't be macroexpanded, and honors local
   bindings."
  [x]
  (cmp/with-base-env
    (if (seq? x)
      (let [frst (first x)]

        (if (contains? (cmp/locals) frst)

          ;; might look like a macro, but for our purposes it isn't
          x

          (let [x' (macroexpand-1 x)]
            (if-not (identical? x x')
              (macroexpand x')

              ;; if we can't macroexpand any further, check if it's an inlined function
              (if-let [inline-fn (and (seq? x')
                                      (symbol? (first x'))
                                      (-> x' meta ::transformed not)
                                      (or
                                        (-> x' first resolve meta :inline-arities not)
                                        ((-> x' first resolve meta :inline-arities)
                                          (count (rest x'))))
                                      (-> x' first resolve meta :inline))]
                (let [x'' (apply inline-fn (rest x'))]
                  (macroexpand
                    ;; unfortunately, static function calls can look a lot like what we just
                    ;; expanded, so prevent infinite expansion
                    (if (= '. (first x''))
                      (with-meta
                        (concat (butlast x'')
                                [(if (instance? IObj (last x''))
                                   (with-meta (last x'')
                                              (merge
                                                (meta (last x''))
                                                {::transformed true}))
                                   (last x''))])
                        (meta x''))
                      x'')))
                x')))))
      x)))

;;;

(defn- do-handler [f [_ & body]]
  (list* 'do
         (doall
           (map f body))))

(defn- fn-handler [f x]
  (let [prelude (take-while (complement sequential?) x)
        remainder (drop (count prelude) x)
        remainder (if (vector? (first remainder))
                    (list remainder) remainder)
        body-handler (fn [x]
                       (cmp/with-lexical-scoping
                         (doseq [arg (first x)]
                           (cmp/register-arg arg))
                         (doall
                           (list* (first x)
                                  (map f (rest x))))))]

    (cmp/with-lexical-scoping

      ;; register a local for the function, if it's named
      (when-let [nm (second prelude)]
        (cmp/register-local nm
                            (list* 'fn* nm
                                   (map #(take 1 %) remainder))))

      (concat
        prelude
        (if (seq? (first remainder))
          (doall (map body-handler remainder))
          [(body-handler remainder)])))))

(defn- def-handler [f x]
  (let [[_ n & r] x]
    (cmp/with-lexical-scoping
      (cmp/register-local n '())
      (list* 'def (f n) (doall (map f r))))))

(defn- let-bindings [f x]
  (->> x
       (partition-all 2)
       (mapcat
         (fn [[k v]]
           (let [[k v] [k (f v)]]
             (cmp/register-local k v)
             [k v])))
       vec))

(defn- reify-handler [f x]
  (let [[_ classes & fns] x]
    (list* 'reify* classes
           (doall
             (map
               (fn [[nm args & body]]
                 (cmp/with-lexical-scoping
                   (doseq [arg args]
                     (cmp/register-arg arg))
                   (list* nm args (doall (map f body)))))
               fns)))))

(defn- deftype-handler [f x]
  (let [[_ type resolved-type args _ interfaces & fns] x]
    (cmp/with-lexical-scoping
      (doseq [arg args]
        (cmp/register-arg arg))
      (list* 'deftype* type resolved-type args :implements interfaces
             (doall
               (map
                 (fn [[nm args & body]]
                   (cmp/with-lexical-scoping
                     (doseq [arg args]
                       (cmp/register-arg arg))
                     (list* nm args (doall (map f body)))))
                 fns))))))

(defn- let-handler [f x]
  (cmp/with-lexical-scoping
    (doall
      (list*
        (first x)
        (let-bindings f (second x))
        (map f (drop 2 x))))))

(defn- case-handler [f x]
  (let [prefix (butlast (take-while (complement map?) x))
        default (last (take-while (complement map?) x))
        body (first (drop-while (complement map?) x))
        suffix (rest (drop-while (complement map?) x))]
    (concat
      prefix
      [(f default)]
      [(let [m (->> body
                    (map
                      (fn [[k [idx form]]]
                        [k [idx (f form)]]))
                    (into {}))]
         (if (every? number? (keys m))
           (into (sorted-map) m)
           m))]
      suffix)))

(defn- catch-handler [f x]
  (let [[_ type var & body] x]
    (cmp/with-lexical-scoping
      (when var
        (cmp/register-arg (with-meta var (merge (meta var) {:tag type}))))
      (list* 'catch type var
             (doall (map f body))))))

(defn- dot-handler [f x]
  (let [[_ hostexpr mem-or-meth & remainder] x]
    (list* '.
           (f hostexpr)
           (if (walkable? mem-or-meth)
             (list* (first mem-or-meth)
                    (doall (map f (rest mem-or-meth))))
             (f mem-or-meth))
           (doall (map f remainder)))))

(defn contains-tag?
  [form]
  (or (-> form meta ::expand-to)
      (if (coll? form) (some contains-tag? form))))

(defn macroexpand-all
  "Recursively macroexpands all forms, preserving the &env special variables."
  [form]
  (cmp/with-base-env
    (let [form (if (instance? IObj form)
                 (vary-meta form dissoc ::expanded)
                 form)
          x (if (contains-tag? form)
              (try
                (macroexpand form)
                (catch ClassNotFoundException _
                  form))
              form)
          x (if-not (identical? x form)
              (if (instance? IObj x)
                (vary-meta x assoc ::expanded true)
                (list ::expanded x))
              x)
          x (if (instance? IObj x)
              (with-meta x (dissoc (merge (select-keys (meta form) [::top-form])
                                          (meta x))
                                   ::expand-to))
              x)
          x' (cond

               (and (walkable? x) (= 'quote (first x)))
               x

               (walkable? x)
               ((condp = (first x)
                  'do do-handler
                  'def def-handler
                  'fn* fn-handler
                  'let* let-handler
                  'loop* let-handler
                  'letfn* let-handler
                  'case* case-handler
                  'catch catch-handler
                  'reify* reify-handler
                  'deftype* deftype-handler
                  '. dot-handler
                  #(doall (map %1 %2)))
                 macroexpand-all x)

               (instance? java.util.Map$Entry x)
               (clojure.lang.MapEntry.
                 (macroexpand-all (key x))
                 (macroexpand-all (val x)))

               (vector? x)
               (vec (map macroexpand-all x))

               (instance? clojure.lang.IRecord x)
               x

               (map? x)
               (into {} (map macroexpand-all x))

               (set? x)
               (set (map macroexpand-all x))

               ;; special case to handle clojure.test
               (and (symbol? x) (-> x meta :test))
               (vary-meta x update-in [:test] macroexpand-all)

               :else
               x)]
      (if (instance? IObj x')
        (with-meta x' (merge (meta x) (meta x')))
        x'))))

