#!/bin/bash

#!/bin/bash

BASH_CLI_SCRIPT_NAME="git.sh"

BASH_CLI_OPT_NAME[0]="-v"
BASH_CLI_OPT_NAME[1]="-C"
BASH_CLI_OPT_NAME[2]="-c"
BASH_CLI_OPT_NAME[3]="-n"
BASH_CLI_OPT_NAME[4]="-html"
BASH_CLI_OPT_NAME[5]="-man"
BASH_CLI_OPT_NAME[6]="-i"
BASH_CLI_OPT_NAME[7]="-pg"
BASH_CLI_OPT_NAME[8]="-npg"
BASH_CLI_OPT_NAME[9]="-nrp"
BASH_CLI_OPT_NAME[10]="-b"
BASH_CLI_OPT_NAME[11]="-d"
BASH_CLI_OPT_NAME[12]="-t"
BASH_CLI_OPT_NAME[13]="-ns"
BASH_CLI_OPT_NAME[14]="clone" 
BASH_CLI_OPT_NAME[15]="init" 
BASH_CLI_OPT_NAME[16]="add" 
BASH_CLI_OPT_NAME[17]="mv" 
BASH_CLI_OPT_NAME[18]="reset" 
BASH_CLI_OPT_NAME[19]="rm" 
BASH_CLI_OPT_NAME[20]="bisect" 
BASH_CLI_OPT_NAME[21]="grep" 
BASH_CLI_OPT_NAME[22]="log" 
BASH_CLI_OPT_NAME[23]="show" 
BASH_CLI_OPT_NAME[24]="status" 
BASH_CLI_OPT_NAME[25]="branch" 
BASH_CLI_OPT_NAME[26]="checkout" 
BASH_CLI_OPT_NAME[27]="commit" 
BASH_CLI_OPT_NAME[28]="diff" 
BASH_CLI_OPT_NAME[29]="merge" 
BASH_CLI_OPT_NAME[30]="rebase" 
BASH_CLI_OPT_NAME[31]="tag" 
BASH_CLI_OPT_NAME[32]="fetch" 
BASH_CLI_OPT_NAME[33]="pull" 
BASH_CLI_OPT_NAME[34]="push" 

BASH_CLI_OPT_ALT_NAME[0]="--version"
BASH_CLI_OPT_ALT_NAME[1]="--path"
BASH_CLI_OPT_ALT_NAME[2]="--name"
BASH_CLI_OPT_ALT_NAME[3]="--exec-path"
BASH_CLI_OPT_ALT_NAME[4]="--html-path"
BASH_CLI_OPT_ALT_NAME[5]="--man-path"
BASH_CLI_OPT_ALT_NAME[6]="--info-path"
BASH_CLI_OPT_ALT_NAME[7]="--paginate"
BASH_CLI_OPT_ALT_NAME[8]="--no-pager"
BASH_CLI_OPT_ALT_NAME[9]="--no-replace-objects"
BASH_CLI_OPT_ALT_NAME[10]="--bare"
BASH_CLI_OPT_ALT_NAME[11]="--git-dir"
BASH_CLI_OPT_ALT_NAME[12]="--work-tree"
BASH_CLI_OPT_ALT_NAME[13]="--namespace"
BASH_CLI_OPT_ALT_NAME[14]="cloneAsClone" 
BASH_CLI_OPT_ALT_NAME[15]="initAsClone" 
BASH_CLI_OPT_ALT_NAME[16]="addAsClone" 
BASH_CLI_OPT_ALT_NAME[17]="mvAsClone" 
BASH_CLI_OPT_ALT_NAME[18]="resetAsClone" 
BASH_CLI_OPT_ALT_NAME[19]="rmAsClone" 
BASH_CLI_OPT_ALT_NAME[20]="bisectAsClone" 
BASH_CLI_OPT_ALT_NAME[21]="grepAsClone" 
BASH_CLI_OPT_ALT_NAME[22]="logAsClone" 
BASH_CLI_OPT_ALT_NAME[23]="showAsClone" 
BASH_CLI_OPT_ALT_NAME[24]="statusAsClone" 
BASH_CLI_OPT_ALT_NAME[25]="branchAsClone" 
BASH_CLI_OPT_ALT_NAME[26]="checkoutAsClone" 
BASH_CLI_OPT_ALT_NAME[27]="commitAsClone" 
BASH_CLI_OPT_ALT_NAME[28]="diffAsClone" 
BASH_CLI_OPT_ALT_NAME[29]="mergeAsClone" 
BASH_CLI_OPT_ALT_NAME[30]="rebaseAsClone" 
BASH_CLI_OPT_ALT_NAME[31]="tagAsClone" 
BASH_CLI_OPT_ALT_NAME[32]="fetchAsClone" 
BASH_CLI_OPT_ALT_NAME[33]="pullAsClone" 
BASH_CLI_OPT_ALT_NAME[34]="pushAsClone" 

BASH_CLI_OPT_DATA_TYPE[0]="string"
BASH_CLI_OPT_DATA_TYPE[1]="string"
BASH_CLI_OPT_DATA_TYPE[2]="string"
BASH_CLI_OPT_DATA_TYPE[3]="string"
BASH_CLI_OPT_DATA_TYPE[4]="string"
BASH_CLI_OPT_DATA_TYPE[5]="string"
BASH_CLI_OPT_DATA_TYPE[6]="string"
BASH_CLI_OPT_DATA_TYPE[7]="string"
BASH_CLI_OPT_DATA_TYPE[8]="string"
BASH_CLI_OPT_DATA_TYPE[9]="string"
BASH_CLI_OPT_DATA_TYPE[10]="string"
BASH_CLI_OPT_DATA_TYPE[11]="string"
BASH_CLI_OPT_DATA_TYPE[12]="string"
BASH_CLI_OPT_DATA_TYPE[13]="string"
BASH_CLI_OPT_DATA_TYPE[14]="cmd"
BASH_CLI_OPT_DATA_TYPE[15]="cmd" 
BASH_CLI_OPT_DATA_TYPE[16]="cmd" 
BASH_CLI_OPT_DATA_TYPE[17]="cmd" 
BASH_CLI_OPT_DATA_TYPE[18]="cmd" 
BASH_CLI_OPT_DATA_TYPE[19]="cmd" 
BASH_CLI_OPT_DATA_TYPE[20]="cmd" 
BASH_CLI_OPT_DATA_TYPE[21]="cmd" 
BASH_CLI_OPT_DATA_TYPE[22]="cmd" 
BASH_CLI_OPT_DATA_TYPE[23]="cmd" 
BASH_CLI_OPT_DATA_TYPE[24]="cmd" 
BASH_CLI_OPT_DATA_TYPE[25]="cmd" 
BASH_CLI_OPT_DATA_TYPE[26]="cmd" 
BASH_CLI_OPT_DATA_TYPE[27]="cmd" 
BASH_CLI_OPT_DATA_TYPE[28]="cmd" 
BASH_CLI_OPT_DATA_TYPE[29]="cmd" 
BASH_CLI_OPT_DATA_TYPE[30]="cmd" 
BASH_CLI_OPT_DATA_TYPE[31]="cmd" 
BASH_CLI_OPT_DATA_TYPE[32]="cmd" 
BASH_CLI_OPT_DATA_TYPE[33]="cmd" 
BASH_CLI_OPT_DATA_TYPE[34]="cmd" 

BASH_CLI_MANDATORY_PARAM[4]="0,1"
BASH_CLI_NON_MANDATORY_PARAM[4]="2,3"

BASH_CLI_OPT_DESC[0]="string"
BASH_CLI_OPT_DESC[1]="string"
BASH_CLI_OPT_DESC[2]="string"
BASH_CLI_OPT_DESC[3]="string"
BASH_CLI_OPT_DESC[4]="string"
BASH_CLI_OPT_DESC[5]="string"
BASH_CLI_OPT_DESC[6]="string"
BASH_CLI_OPT_DESC[7]="string"
BASH_CLI_OPT_DESC[8]="string"
BASH_CLI_OPT_DESC[9]="string"
BASH_CLI_OPT_DESC[10]="string"
BASH_CLI_OPT_DESC[11]="string"
BASH_CLI_OPT_DESC[12]="string"
BASH_CLI_OPT_DESC[13]="string"
BASH_CLI_OPT_DESC[14]="[start a working area] Clone a repository into a new directory" 
BASH_CLI_OPT_DESC[15]="[start a working area] Create an empty Git repository or reinitialize an existing one" 
BASH_CLI_OPT_DESC[16]="[work on the current change] Add file contents to the index" 
BASH_CLI_OPT_DESC[17]="[work on the current change] Move or rename a file, a directory, or a symlink" 
BASH_CLI_OPT_DESC[18]="[work on the current change] Reset current HEAD to the specified state" 
BASH_CLI_OPT_DESC[19]="[work on the current change] Remove files from the working tree and from the index" 
BASH_CLI_OPT_DESC[20]="[examine the history and state] Use binary search to find the commit that introduced a bug" 
BASH_CLI_OPT_DESC[21]="[examine the history and state] Print lines matching a pattern" 
BASH_CLI_OPT_DESC[22]="[examine the history and state] Show commit logs" 
BASH_CLI_OPT_DESC[23]="[examine the history and state] Show various types of objects" 
BASH_CLI_OPT_DESC[24]="[examine the history and state] Show the working tree status" 
BASH_CLI_OPT_DESC[25]="[grow, mark and tweak your common history] List, create, or delete branches" 
BASH_CLI_OPT_DESC[26]="[grow, mark and tweak your common history] Switch branches or restore working tree files" 
BASH_CLI_OPT_DESC[27]="[grow, mark and tweak your common history] Record changes to the repository" 
BASH_CLI_OPT_DESC[28]="[grow, mark and tweak your common history] Show changes between commits, commit and working tree, etc" 
BASH_CLI_OPT_DESC[29]="[grow, mark and tweak your common history] Join two or more development histories together" 
BASH_CLI_OPT_DESC[30]="[grow, mark and tweak your common history] Forward-port local commits to the updated upstream head" 
BASH_CLI_OPT_DESC[31]="[grow, mark and tweak your common history] Create, list, delete or verify a tag object signed with GPG" 
BASH_CLI_OPT_DESC[32]="[collaborate] Download objects and refs from another repository" 
BASH_CLI_OPT_DESC[33]="[collaborate] Fetch from and integrate with another repository or a local branch" 
BASH_CLI_OPT_DESC[34]="[collaborate] Update remote refs along with associated objects"

clone() {
    echo "clone"
}

init() {
    echo "init" 
}

add() {
    echo "add"
}

mv() {
    echo "mv"
}

reset() { 
    echo "reset"
}

rm() {
    echo "rm"
}

bisect() { 
    echo "bisect"
}

grep() {
    echo "grep"
}

log() {
    echo "log"
}

show() {
    echo "show"
}

status() {
    echo "status"
}

branch() {
    echo "branch"
}

checkout() {
    echo "checkout"
}

commit() {
    echo "commit"
}

diff() {
    echo "diff"
}

merge() {
    echo "merge"
}

rebase() {
    echo "rebase"
}

tag() {
    echo "tag"
}

fetch() {
    echo "fetch"
}

pull() {
    echo "pull"
}

push() {
    echo "push"
}

source ../base.sh