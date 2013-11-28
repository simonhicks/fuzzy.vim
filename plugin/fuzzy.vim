if exists("g:loaded_fuzzy") || &cp || v:version < 700
  finish
endif
let g:loaded_fuzzy = 1

if !exists('g:fuzzy_provide_mappings')
  let g:fuzzy_provide_mappings = 1
endif

command! -complete=file -nargs=1 FuzzyOpenFile :call fuzzy#OpenFile("<args>")
command! -complete=file -nargs=1 FuzzySplitFile :call fuzzy#SplitFile("<args>")
command! -complete=file -nargs=1 FuzzyVSplitFile :call fuzzy#VSplitFile("<args>")
command! -complete=file -nargs=1 FuzzyTabOpenFile :call fuzzy#TabOpenFile("<args>")

command! -complete=buffer -nargs=1 FuzzyOpenBuffer :call fuzzy#OpenBuffer("<args>")
command! -complete=buffer -nargs=1 FuzzySplitBuffer :call fuzzy#SplitBuffer("<args>")
command! -complete=buffer -nargs=1 FuzzyVSplitBuffer :call fuzzy#VSplitBuffer("<args>")
command! -complete=buffer -nargs=1 FuzzyTabOpenBuffer :call fuzzy#TabOpenBuffer("<args>")

if g:fuzzy_provide_mappings
  if !exists('g:fuzzy_leader')
    let g:fuzzy_leader = '<space>'
  endif
  execute 'nnoremap ' . g:fuzzy_leader . 'fo :FuzzyOpenFile<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'ft :FuzzyTabOpenFile<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'fv :FuzzyVSplitFile<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'fs :FuzzySplitFile<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'bo :FuzzyOpenBuffer<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'bt :FuzzyTabOpenBuffer<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'bv :FuzzyVSplitBuffer<space>'
  execute 'nnoremap ' . g:fuzzy_leader . 'bs :FuzzySplitBuffer<space>'
  if !exists('g:fuzzy_find_cword')
    let g:fuzzy_find_cword = '<C-f>'
  endif
  execute 'nnoremap ' . g:fuzzy_find_cword . ' :FuzzyOpenFile <cword><CR>'
endif
