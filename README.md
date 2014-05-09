# fuzzy.vim

fuzzy.vim is a lightweight plugin for opening files and buffers using regular
expressions. If you tell it to find a file, it uses the unix find command to
recursively search your current directory for files matching the pattern you
give it and if you tell it to open a buffer, it will search the list of existing
and listed buffers for a buffer whose name matches that pattern.

I wrote it entirely in a single afternoon when I got annoyed at hitting tab
four hundred times to open a single java file, so don't be surprised if it
doesn't do anything smart. It's *supposed* to be simple.


## USAGE

Fuzzy.vim provides the following commands for opening files. Hopefully it's
obvious what they do.

* `:FuzzyOpenFile <pattern>`
* `:FuzzyTabOpenFile <pattern>`
* `:FuzzySplitFile <pattern>`
* `:FuzzyVSplitFile <pattern>`

Similarly, it provides matching commands for opening buffers.

* `:FuzzyOpenBuffer <pattern>`
* `:FuzzyTabOpenBuffer <pattern>`
* `:FuzzySplitBuffer <pattern>`
* `:FuzzyVSplitBuffer <pattern>`

By default, Fuzzy.vim will add these mappings to normal mode.

* `map <FuzzyLeader>fo :FuzzyOpenFile<space>`
* `map <FuzzyLeader>ft :FuzzyTabOpenFile<space>`
* `map <FuzzyLeader>fs :FuzzySplitFile<space>`
* `map <FuzzyLeader>fv :FuzzyVSplitFile<space>`
* `map <FuzzyLeader>bo :FuzzyOpenBuffer<space>`
* `map <FuzzyLeader>bt :FuzzyTabOpenBuffer<space>`
* `map <FuzzyLeader>bs :FuzzySplitBuffer<space>`
* `map <FuzzyLeader>bv :FuzzyVSplitBuffer<space>`

Since it's particularly common to want to look for a file/buffer that matches a word in the file, there is
another shortcut to look for files/buffers matching the word currently under the cursor. By default these are
bound to `<FuzzyLeader><C-f>` and `<FuzzyLeader><C-b>`, but can be configured (see below)

## Configuration

### `g:fuzzy_leader`
Set this to the string you would like fuzzy to use as the prefix to it's normal
mode mappings. Defaults to `<space>`

### `g:fuzzy_file_exclusions`
This is a list of regular expressions which you always want to exclude from your
list of file matches. Defaults to `['.*\.class$']` (to exclude jvm class files)

### `g:fuzzy_find_file_cword`
This defines the binding to search for a file matching the word currently under the cursor.  Defaults to
`g:fuzzy_leader + <C-f>`

### `g:fuzzy_find_buffer_cword`
This defines the binding to search for a buffer matching the word currently under the cursor.  Defaults to
`g:fuzzy_leader + <C-b>`

### `g:fuzzy_exclude_current`
Set this to 1 to tell fuzzy to exclude the current file/buffer from the search.
Defaults to 0

### `g:fuzzy_provide_mappings`
Set this to 0 to tell fuzzy not to add any mappings. Defaults to 1
