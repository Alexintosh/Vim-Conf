" BlockComment.vim
" Author: Chris Russell, Kevin Vicrey (improvement)
" Version: 1.1
" License: GPL v2.0 
" 
" Description:
" This script defineds functions and key mappings to block comment code.
" 
" Help: 
" In brief, use '.c' to comment and '.C' to uncomment.
" 
" Both commenting and uncommenting can be run on N lines at a time by 
" using a number before the command.  They both support visual mode and 
" ranges.
" 
" This script will not comment lines with an indent level less that the 
" initial line of the comment to preserve the control structure of code.
"
" Installation:
" Simply drop this file into your plugin directory.
" 
" Changelog:
" 2002-11-08 v1.1
" 	Convert to Unix eol
" 2002-11-05 v1.0
" 	Initial release
" 
" TODO:
" Add more file types
" 


"--------------------------------------------------
" Avoid multiple sourcing
"-------------------------------------------------- 
if exists( "loaded_block_comment" )
	finish
endif
let loaded_block_comment = 1


"--------------------------------------------------
" Key mappings
"-------------------------------------------------- 
noremap <silent>  :call ToggleComment()<CR>


"--------------------------------------------------
" Set comment characters by filetype
"-------------------------------------------------- 
function! CommentStr()
	let s:comment_pad = '--------------------------------------------------'
	if &ft == "vim"
		let s:comment_strt = ''
		let s:comment_mid = '"'
		let s:comment_stop = ''
	elseif &ft == "html" || &ft == "eruby"
		let s:comment_strt = '<!--'
		let s:comment_mid  = ''
		let s:comment_stop = '-->'
	elseif &ft == "tex"
		let s:comment_strt = ''
		let s:comment_mid  = '%'
		let s:comment_stop = ''
	elseif &ft == "ruby"
		let s:comment_strt = '=begin'
		let s:comment_mid  = ''
		let s:comment_stop = '=end'
	elseif &ft == "c" || &ft == "css" || &ft == "cpp" || &ft == "java" || &ft == "javascript" || &ft == "php"
		let s:comment_strt = '/*'
		let s:comment_mid = ' * '
		let s:comment_stop = ' */'
	elseif &ft == "asm" || &ft == "lisp" || &ft == "scheme"
		let s:comment_strt = ''
		let s:comment_mid  = '; '
		let s:comment_stop = ''
	elseif &ft == "html" || &ft == "xml" || &ft == "entity"
		let s:comment_strt = '<!--'
		let s:comment_mid  = ''
		let s:comment_stop = '-->'
	else
		let s:comment_strt = ''
		let s:comment_mid  = '# '
		let s:comment_stop = ''
	endif
endfunction

"--------------------------------------------------
" Toggle comment a block of code
"-------------------------------------------------- 
function! ToggleComment() range
	" range variables
	let l:firstln = a:firstline
	let l:lastln = a:lastline

	" get comment chars
	call CommentStr()

    " First line
    if s:comment_strt != '' && getline(l:firstln) == s:comment_strt
      call UnComment(l:firstln, l:lastln)
      return
    endif

    " Middle line
    if s:comment_mid != '' && match( getline(l:firstln), "^" . escape( s:comment_mid, '\*^$.~[]' )) != -1
      call UnComment(l:firstln, l:lastln)
      return
    endif

    call Comment(l:firstln, l:lastln)
endfunction

"--------------------------------------------------
" Comment a block of code
"-------------------------------------------------- 
function! Comment(first, last)
	" range variables
	let l:firstln = a:first
	let l:lastln = a:last

	" get comment chars
	call CommentStr()

	let l:midline = l:firstln

    " First line
    if s:comment_strt != ''
      call append( l:firstln - 1, s:comment_strt )
      let l:lastln = l:lastln + 1
      let l:midline = l:firstln + 1
    endif

	" loop for each line
	while l:midline <= l:lastln
      call setline( l:midline, s:comment_mid . getline(l:midline) )
	  let l:midline = l:midline + 1
	endwhile
  
	" end line
    if s:comment_stop != ''
      call append( l:lastln, s:comment_stop )
    endif

    execute l:firstln
endfunction

"--------------------------------------------------
" Uncomment a block of code
"-------------------------------------------------- 
function! UnComment(first, last)
	" range variables
	let l:firstln = a:first
	let l:lastln = a:last

	" get comment chars
	call CommentStr()

    if s:comment_strt != '' && getline(l:firstln) != s:comment_strt || s:comment_stop != '' && getline(l:lastln) != s:comment_stop
      echohl WarningMsg
      echo getline(l:firstln)
      echo getline(l:lastln)
      echo "This range doesn't begin (or end) with comment marker"
      echohl None
      return
    endif

    " First line
    if s:comment_strt != ''
      execute l:firstln . "d"
      let l:lastln  = l:lastln - 1
      "let l:firstln = l:firstln + 1
    endif

    " Middle lines
    let l:midline = l:firstln
    if s:comment_mid != ''
      while l:midline < l:lastln
          execute l:midline . "s/" . escape( s:comment_mid, '\*^$.~[]' ) . "//"
          let l:midline = l:midline + 1
      endwhile
    end
    
    " Last line
    if s:comment_stop != ''
      execute l:lastln . "d"
    else
      execute l:lastln . "s/" . escape( s:comment_mid, '\*^$.~[]' ) . "//"
    endif

    execute l:lastln - 1
endfunction

