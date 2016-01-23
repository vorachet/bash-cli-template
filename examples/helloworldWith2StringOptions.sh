#!/bin/bash

BASH_CLI_SCRIPT_NAME="hellowordWith2StringOptions.sh"

BASH_CLI_OPT_NAME[0]="-p"
BASH_CLI_OPT_NAME[1]="-t"
BASH_CLI_OPT_NAME[2]="-u"
BASH_CLI_OPT_NAME[3]="-l"
BASH_CLI_OPT_NAME[4]="hello"

BASH_CLI_OPT_ALT_NAME[0]="--text"
BASH_CLI_OPT_ALT_NAME[1]="--prefix"
BASH_CLI_OPT_ALT_NAME[2]="--uppercase"
BASH_CLI_OPT_ALT_NAME[3]="--lowercase"
BASH_CLI_OPT_ALT_NAME[4]="helloworld" 

BASH_CLI_OPT_DATA_TYPE[0]="string"
BASH_CLI_OPT_DATA_TYPE[1]="string"
BASH_CLI_OPT_DATA_TYPE[2]="boolean"
BASH_CLI_OPT_DATA_TYPE[3]="boolean"
BASH_CLI_OPT_DATA_TYPE[4]="cmd"

BASH_CLI_MANDATORY_PARAM[4]="0,1"
BASH_CLI_NON_MANDATORY_PARAM[4]="2,3"

BASH_CLI_OPT_DESC[0]="text"
BASH_CLI_OPT_DESC[1]="prefix word to put infront of the given text"
BASH_CLI_OPT_DESC[2]="use uppercase"
BASH_CLI_OPT_DESC[3]="use lowercase"
BASH_CLI_OPT_DESC[4]="To print text from the value of -t"

hello() {
    local prefix=${BASH_CLI_OPT_VALUE[0]}
    local text=${BASH_CLI_OPT_VALUE[1]}
    local enabled_uppercase=${BASH_CLI_OPT_VALUE[2]}
    local enabled_lowercase=${BASH_CLI_OPT_VALUE[3]}

    if [ ${enabled_uppercase} == true ]; then
        echo "${prefix} ${text}" | tr '[:lower:]' '[:upper:]'
    elif [ ${enabled_lowercase} == true ]; then
        echo "${prefix} ${text}" | tr '[:upper:]' '[:lower:]'
    else 
        echo "${prefix} ${text}" 
    fi 
    exit
}

source ../base.sh