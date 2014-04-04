" (https://github.com/Pychimp/vim-mirodark)

let g:airline#themes#mirodark#palette = {}

let g:airline#themes#mirodark#palette.accents = {
      \ 'red': [ '#ffffff' , '' , 231 , '' , '' ],
      \ }


let s:N1 = [ '#ffffff' , '#073642' , 231  , 36 ]
let s:N2 = [ '#ffffff' , '#002B36' , 231 , 29 ]
let s:N3 = [ '#ffffff' , '#080808' , 231  , 23 ]
let g:airline#themes#mirodark#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
" let g:airline#themes#mirodark#palette.normal_modified = {
"       \ 'airline_c': [ '#ffffff' , '#450000' , 231     , 52      , ''     ] ,
"       \ }


let s:I1 = [ '#ffffff' , '#003623' , 231 , 106 ]
let s:I2 = [ '#ffffff' , '#002B36' , 231 , 29  ]
let s:I3 = [ '#ffffff' , '#080808' , 231 , 23  ]
let g:airline#themes#mirodark#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
" let g:airline#themes#mirodark#palette.insert_modified = {
"       \ 'airline_c': [ '#ffffff' , '#005e5e' , 255     , 52      , ''     ] ,
"       \ }
let g:airline#themes#mirodark#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#003623' , s:I1[2] , 106     , ''     ] ,
      \ }


let g:airline#themes#mirodark#palette.replace = copy(g:airline#themes#mirodark#palette.insert)
let g:airline#themes#mirodark#palette.replace.airline_a = [ s:I2[0]   , '#920000' , s:I2[2] , 88     , ''     ]
" let g:airline#themes#mirodark#palette.replace_modified = g:airline#themes#mirodark#palette.insert_modified

let s:V1 = [ '#ffff9a' , '#680020' , 222 , 208 ]
let s:V2 = [ '#ffffff' , '#002B36' , 231 , 29 ]
let s:V3 = [ '#ffffff' , '#080808' , 231  , 23  ]
let g:airline#themes#mirodark#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
" let g:airline#themes#mirodark#palette.visual_modified = {
"       \ 'airline_c': [ '#ffffff' , '#450000' , 231     , 52      , ''     ] ,
"       \ }

let s:IA = [ '#4e4e4e' , '#080808' , 59 , 23 , '' ]
let g:airline#themes#mirodark#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
" let g:airline#themes#mirodark#palette.inactive_modified = {
"       \ 'airline_c': [ '#450000' , ''        , 52      , ''      , ''     ] ,
"       \ }

let g:airline#themes#mirodark#palette.tabline = {
      \ 'airline_tabsel':  ['#ffffff', '#2e8b57',  231, 36, ''],
      \ 'airline_tabtype':  ['#ffffff', '#073642',  231, 36, ''],
      \ 'airline_tabfill':  ['#ffffff', '#080808',  231, 23, ''],
      \ 'airline_tabmod':  ['#ffffff', '#780000',  231, 88, ''],
      \ }

let s:WI = [ '#ffffff', '#5f0000', 231, 88 ]
let g:airline#themes#mirodark#palette.normal.airline_warning = [
     \ s:WI[0], s:WI[1], s:WI[2], s:WI[3]
     \ ]

" let g:airline#themes#mirodark#palette.normal_modified.airline_warning =
"     \ g:airline#themes#mirodark#palette.normal.airline_warning

let g:airline#themes#mirodark#palette.insert.airline_warning =
    \ g:airline#themes#mirodark#palette.normal.airline_warning

" let g:airline#themes#mirodark#palette.insert_modified.airline_warning =
"     \ g:airline#themes#mirodark#palette.normal.airline_warning

let g:airline#themes#mirodark#palette.visual.airline_warning =
    \ g:airline#themes#mirodark#palette.normal.airline_warning
d
" let g:airline#themes#mirodark#palette.visual_modified.airline_warning =
"     \ g:airline#themes#mirodark#palette.normal.airline_warning

let g:airline#themes#mirodark#palette.replace.airline_warning =
    \ g:airline#themes#mirodark#palette.normal.airline_warning

" let g:airline#themes#mirodark#palette.replace_modified.airline_warning =
"     \ g:airline#themes#mirodark#palette.normal.airline_warning

" 
" if !get(g:, 'loaded_ctrlp', 0)
"   finish
" endif
" let g:airline#themes#mirodark#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
"       \ [ '#ffffff' , '#973d45' , 231 , 95 , ''     ] )
" 
