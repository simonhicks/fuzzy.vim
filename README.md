# fuzzy.vim

fuzzy.vim is a lightweight plugin for opening files and buffers using regular
expressions. If you tell it to find a file, it uses the unix find command to
recursively search your current directory for files matching the pattern you
give it and if you tell it to open a buffer, it will search the list of existing
and listed buffers for a buffer whose name matches that pattern.

I wrote it entirely in a single afternoon when I got annoyed at hitting tab
four hundred times to open a single java file, so don't be surprised if it
doesn't do anything smart. It's supposed to be simple.


## USAGE

Fuzzy.vim provides the following commands for opening files. Hopefully it's
obvious what they do.

* :FuzzyOpenFile \<pattern\>
* :FuzzyTabOpenFile \<pattern\>
* :FuzzySplitFile \<pattern\>
* :FuzzyVSplitFile \<pattern\>

Similarly, it provides the matching commands for opening buffers.

* :FuzzyOpenBuffer \<pattern\>
* :FuzzyTabOpenBuffer \<pattern\>
* :FuzzySplitBuffer \<pattern\>
* :FuzzyVSplitBuffer \<pattern\>

By default, Fuzzy.vim will also add these mappings to normal mode.

* map \<FuzzyLeader\>fo :FuzzyOpenFile\<space\>
* map \<FuzzyLeader\>ft :FuzzyTabOpenFile\<space\>
* map \<FuzzyLeader\>fs :FuzzySplitFile\<space\>
* map \<FuzzyLeader\>fv :FuzzyVSplitFile\<space\>
* map \<FuzzyLeader\>bo :FuzzyOpenBuffer\<space\>
* map \<FuzzyLeader\>bt :FuzzyTabOpenBuffer\<space\>
* map \<FuzzyLeader\>bs :FuzzySplitBuffer\<space\>
* map \<FuzzyLeader\>bv :FuzzyVSplitBuffer\<space\>


## Configuration

### g:fuzzy\_leader
Set this to the string you would like fuzzy to use as the prefix to it's normal
mode mappings. Defaults to '\<space\>'

### g:fuzzy\_file\_exclusions
This is a list of regular expressions which you always want to exclude from your
list of file matches. Defaults to \['.\*\\.class$'\] (to exclude jvm class files)

### g:fuzzy\_provide\_mappings
Set this to 0 to tell fuzzy.vim not to add any mappings. Defaults to 1

