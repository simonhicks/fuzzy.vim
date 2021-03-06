if exists("g:autoloaded_fuzzy")
  finish
endif
let g:autoloaded_fuzzy = 1

let uname = system("uname")
if match(uname, "Linux") >= 0
  let g:fuzzy_os_type = 'linux'
elseif match(uname, "Darwin")
  let g:fuzzy_os_type = 'darwin'
else
  throw "Fuzzy.vim only supports Darwin based and Linux based operating systems"
  finish
endif

if !exists('g:fuzzy_file_exclusions')
  let g:fuzzy_file_exclusions = [
        \'.*\.class$'
        \]
endif

if !exists('g:fuzzy_exclude_current')
  let g:fuzzy_exclude_current = 0
endif

function! s:FileExcluded(file)
  let exclude = isdirectory(a:file) || (g:fuzzy_exclude_current && fnamemodify(a:file, ':p') == expand('%:p'))
  for exclusion in g:fuzzy_file_exclusions
    if exclude || (match(a:file, exclusion) != -1)
      let exclude = 1
    endif
  endfor
  return exclude
endfunction

function! s:BufferExcluded(bufferNumber)
  return !buflisted(a:bufferNumber) || (g:fuzzy_exclude_current && buffer_number('%') == a:bufferNumber)
endfunction

function! s:IsExcluded(ident, type)
  if a:type == 'file'
    return s:FileExcluded(a:ident)
  else
    return s:BufferExcluded(a:ident)
  endif
endfunction

if g:fuzzy_os_type ==# 'linux'
  let s:extended_regex_flag_and_path = '. -regextype posix-extended'
elseif g:fuzzy_os_type ==# 'darwin'
  let s:extended_regex_flag_and_path = '-E .'
endif

function! s:FileList(pattern)
  return split(system("find " . s:extended_regex_flag_and_path . " -regex .*" . a:pattern . ".*"), "\n")
endfunction

function! s:BufferList(pattern)
  let maxbufnr = bufnr("$")
  let currbufnr = 1
  let matched = []

  while currbufnr <= maxbufnr
    if (bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if (match(currbufname, a:pattern) > -1)
        call add(matched, currbufnr)
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  return matched
endfunction

function! s:GetList(pattern, type)
  if a:type == 'file'
    return s:FileList(a:pattern)
  else
    return s:BufferList(a:pattern)
  end
endfunction

function! s:ListValidMatches(pattern, type)
  let itemList = s:GetList(a:pattern, a:type)
  let filteredList = []
  for item in itemList
    if !s:IsExcluded(item, a:type)
      call add(filteredList, item)
    endif
  endfor
  return filteredList
endfunction

function! s:FileName(file)
  return a:file
endfunction

function! s:BufferName(bufferNumber)
  return bufname(a:bufferNumber)
endfunction

function! s:GetName(item, type)
  if a:type == 'file'
    return s:FileName(a:item)
  else
    return s:BufferName(a:item)
  endif
endfunction

function! s:Choose(pattern, type)
  let itemList = s:ListValidMatches(a:pattern, a:type)
  if len(itemList) == 1
    return itemList[0]
  elseif len(itemList)
    let i = 0
    for item in itemList
      echom string(i) . ") " . s:GetName(item, a:type)
      let i += 1
    endfor
    let chosen = input("Please enter number: ")
    if chosen != ''
      return itemList[chosen]
    endif
  else
    echom "Couldn't find " . a:type . " matching '" . a:pattern . "'"
    return -1
  endif
endfunction

function! fuzzy#OpenFile(pattern)
  let path = s:Choose(a:pattern, 'file')
  if path != '0' && path != -1
    execute "open " . path
  endif
endfunction

function! fuzzy#TabOpenFile(pattern)
  let path = s:Choose(a:pattern, 'file')
  if path != '0' && path != -1
    execute "tabnew " . path
  endif
endfunction

function! fuzzy#SplitFile(pattern)
  let path = s:Choose(a:pattern, 'file')
  if path != '0' && path != -1
    execute "split " . path
  endif
endfunction

function! fuzzy#VSplitFile(pattern)
  let path = s:Choose(a:pattern, 'file')
  if path != '0' && path != -1
    execute "vsplit " . path
  endif
endfunction

function! fuzzy#OpenCwordFile()
  call fuzzy#OpenFile(expand("<cword>"))
endfunction

function! fuzzy#OpenBuffer(pattern)
  let bnum = s:Choose(a:pattern, 'buffer')
  if bnum && bnum != -1
    execute "buffer " . bnum
  endif
endfunction

function! fuzzy#TabOpenBuffer(pattern)
  let bnum = s:Choose(a:pattern, 'buffer')
  if bnum && bnum != -1
    execute "tab sbuffer " . bnum
  endif
endfunction

function! fuzzy#SplitBuffer(pattern)
  let bnum = s:Choose(a:pattern, 'buffer')
  if bnum && bnum != -1
    execute "sbuffer " . bnum
  endif
endfunction

function! fuzzy#VSplitBuffer(pattern)
  let bnum = s:Choose(a:pattern, 'buffer')
  if bnum && bnum != -1
    execute "vert sbuffer " . bnum
  endif
endfunction

function! fuzzy#OpenCwordBuffer()
  call fuzzy#OpenBuffer(expand("<cword>"))
endfunction
