" LaTeX filetype plugin
" Languages:    BibTeX
" Maintainer:   Elias Toivanen
" Version:      1.3.7
" Last Change:  
" License:      GPL

"************************************************************************
"
"                     TeX-9 library: Python module
"
"    This program is free software: you can redistribute it and/or modify
"    it under the terms of the GNU General Public License as published by
"    the Free Software Foundation, either version 3 of the License, or
"    (at your option) any later version.
"
"    This program is distributed in the hope that it will be useful,
"    but WITHOUT ANY WARRANTY; without even the implied warranty of
"    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"    GNU General Public License for more details.
"
"    You should have received a copy of the GNU General Public License
"    along with this program. If not, see <http://www.gnu.org/licenses/>.
"                    
"    Copyright Elias Toivanen, 2011, 2012, 2013
"
"
"************************************************************************

if !has('python') 
    echoerr "TeX-9: a Vim installation with +python is required"
    finish
endif

" Let the user have the last word
if exists('g:tex_nine_config') && has_key(g:tex_nine_config, 'disable') 
    if g:tex_nine_config.disable 
        redraw
        echomsg("TeX-9: Disabled by user.")
        finish
    endif
endif

" Load Vimscript only once per buffer
if exists('b:init_tex_nine')
    finish
endif
let b:init_tex_nine = 1

"***********************************************************************
ru ftplugin/tex_nine/tex_nine_common.vim
call tex_nine#AddBuffer(b:tex_nine_config, b:bib_nine_snippets)

"***********************************************************************

" Save old leader
if exists('g:maplocalleader')
    let s:maplocalleader_saved = g:maplocalleader
endif
let g:maplocalleader = b:tex_nine_config.leader

inoremap <buffer><expr> <nop>B tex_nine#InsertSnippet()

" Greek
inoremap <buffer> <nop>a \alpha
inoremap <buffer> <nop>b \beta
inoremap <buffer> <nop>c \chi
inoremap <buffer> <nop>d \delta
inoremap <buffer> <nop>e \epsilon
inoremap <buffer> <nop>f \phi
inoremap <buffer> <nop>g \gamma
inoremap <buffer> <nop>h \eta
inoremap <buffer> <nop>k \kappa
inoremap <buffer> <nop>l \lambda
inoremap <buffer> <nop>m \mu
inoremap <buffer> <nop>n \nu
inoremap <buffer> <nop>o \omega
inoremap <buffer> <nop>p \pi
inoremap <buffer> <nop>q \theta
inoremap <buffer> <nop>r \rho
inoremap <buffer> <nop>s \sigma
inoremap <buffer> <nop>t \tau
inoremap <buffer> <nop>u \upsilon
inoremap <buffer> <nop>w \varpi
inoremap <buffer> <nop>x \xi
inoremap <buffer> <nop>y \psi
inoremap <buffer> <nop>z \zeta
inoremap <buffer> <nop>D \Delta
inoremap <buffer> <nop>F \Phi
inoremap <buffer> <nop>G \Gamma
inoremap <buffer> <nop>L \Lambda
inoremap <buffer> <nop>O \Omega
inoremap <buffer> <nop>P \Pi
inoremap <buffer> <nop>Q \Theta
inoremap <buffer> <nop>U \Upsilon
inoremap <buffer> <nop>X \Xi
inoremap <buffer> <nop>Y \Psi

" Math
inoremap <buffer> <nop>½ \sqrt{}<Left>
inoremap <buffer> <nop>N \nabla
inoremap <buffer> <nop>S \sum_{}^{}<Esc>F}i
inoremap <buffer> <nop>I \int\limits_{}^{}<Esc>F}i
inoremap <buffer> <nop>0 \emptyset
inoremap <buffer> <nop>6 \partial
inoremap <buffer> <nop>i \infty
inoremap <buffer> <nop>/ \frac{}{}<Esc>F}i
inoremap <buffer> <nop>v \vee
inoremap <buffer> <nop>& \wedge
inoremap <buffer> <nop>@ \circ
inoremap <buffer> <nop>\ \setminus
inoremap <buffer> <nop>= \equiv
inoremap <buffer> <nop>- \bigcap
inoremap <buffer> <nop>+ \bigcup
inoremap <buffer> <nop>< \leq
inoremap <buffer> <nop>> \geq
inoremap <buffer> <nop>~ \tilde{}<Left>
inoremap <buffer> <nop>^ \hat{}<Left>
inoremap <buffer> <nop>_ \bar{}<Left>
inoremap <buffer> <nop>. \dot{}<Left>
inoremap <buffer> <nop><CR> \nonumber\\<CR>

" Enlarged delimiters
inoremap <buffer> <nop>( \left(\right)<Esc>F(a
inoremap <buffer> <nop>[ \left[\right]<Esc>F[a
inoremap <buffer> <nop>{ \left\{ \right\}<Esc>F a

" Neat insertion of various LaTeX constructs by tapping keys
inoremap <buffer><expr> _ tex_nine#IsLeft('_') ? '{}<Left>' : '_'
inoremap <buffer><expr> ^ tex_nine#IsLeft('^') ? '{}<Left>' : '^'
inoremap <buffer><expr> = tex_nine#IsLeft('=') ? '<BS>&=' : '='
inoremap <buffer><expr> ~ tex_nine#IsLeft('~') ? '<BS>\approx' : '~'
inoremap <buffer><expr> < tex_nine#IsLeft('<') ? '<BS>\ll' : '<'
inoremap <buffer><expr> > tex_nine#IsLeft('>') ? '<BS>\gg' : '>'

if exists('s:maplocalleader_saved')
    let g:maplocalleader = s:maplocalleader_saved
else
    unlet g:maplocalleader
endif
