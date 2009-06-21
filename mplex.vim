" Vim syntax file
" Language:	mplex
" Maintainer:	FURUHASHI Sadayuki <frsyuki _at_ users.sourceforge.jp>
" Last Change:	2009 June 19

if exists("b:current_syntax")
  finish
endif

runtime! syntax/cpp.vim
unlet! b:current_syntax

let b:ruby_no_expensive = 1
syn include @rubyTop syntax/ruby.vim
hi link rubyControl rubyDefine

syn cluster mplRegions contains=mplLine,mplBlock,mplExpression,mplComment

syn region mplHeader matchgroup=mplDelimiter start="^__BEGIN__$" end="^__END__$" contains=@rubyTop containedin=ALLBUT,@mplRegions

syn region mplLine        matchgroup=mplDelimiter start="^[ \t]*%"   end="$"   contains=@rubyTop containedin=ALLBUT,@mplRegions keepend oneline
syn region mplQualifier   matchgroup=mplDelimiter start="%>"         end="$"   contains=@rubyTop containedin=ALLBUT,@mplRegions keepend oneline
syn region mplBlock       matchgroup=mplDelimiter start="\[%"        end="%\]" contains=@rubyTop containedin=ALLBUT,@mplRegions
syn region mplExpression  matchgroup=mplDelimiter start="\[%:"       end="%\]" contains=@rubyTop containedin=ALLBUT,@mplRegions
syn region mplLineProc    matchgroup=mplDelimiter start="%|[a-z0-9,&*()]*|" end="$" contains=@rubyTop containedin=ALLBUT,@mplRegions keepend oneline
"syn region mplLineComment matchgroup=mplDelimiter start="^[ \t]*%#"  end="$"   contains=@rubyTop containedin=ALLBUT,@mplRegions keepend oneline
"syn region mplComment     matchgroup=mplDelimiter start="\[%#"       end="%\]" contains=@rubyTop containedin=ALLBUT,@mplRegions

hi def link mplDelimiter    Delimiter
"hi def link mplLineComment  Comment
"hi def link mplComment      Comment

let b:current_syntax = 'mplex'

