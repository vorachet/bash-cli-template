#!/bin/bash

# Implementation of your script 
#     SCRIPT_NAME
#     DOMAIN_OPTION_NAME[]
#     DOMAIN_OPTION_ALTERNATIVE_NAME[]
#     DOMAIN_OPTION_DATA_TYPE[]
#     DOMAIN_CMD_MANDATORY_OPTIONS[]
#     DOMAIN_CMD_OPTIONS[]
#     DOMAIN_OPTION_INPUT_DESC[]

# Script name
SCRIPT_NAME="example1"

# Option name
DOMAIN_OPTION_NAME[0]="-t"
DOMAIN_OPTION_NAME[1]="-u"
DOMAIN_OPTION_NAME[2]="-l"
DOMAIN_OPTION_NAME[3]="hello"

# Alternative option name
DOMAIN_OPTION_ALTERNATIVE_NAME[0]="--text"
DOMAIN_OPTION_ALTERNATIVE_NAME[1]="--uppercase"
DOMAIN_OPTION_ALTERNATIVE_NAME[2]="--lowercase"
DOMAIN_OPTION_ALTERNATIVE_NAME[3]="helloworld" 

# Option data type. It consists of string, boolean, and cmd.
#   string does not allow you set empty option value
#   object allows you flag the option without giving value
#   cmd is the command used in various situations in your script. 
#   cmd may require one or more mandatory or optional parameters
DOMAIN_OPTION_DATA_TYPE[0]='string'
DOMAIN_OPTION_DATA_TYPE[1]='boolean'
DOMAIN_OPTION_DATA_TYPE[2]='boolean'
DOMAIN_OPTION_DATA_TYPE[3]='cmd'

# Setting mandatory parameters for cmd
DOMAIN_CMD_MANDATORY_OPTIONS[3]="0"

# Setting optional parameters for cmd
DOMAIN_CMD_OPTIONS[3]="1,2"

# Option input description
DOMAIN_OPTION_INPUT_DESC[0]="text"
DOMAIN_OPTION_INPUT_DESC[1]="use uppercase"
DOMAIN_OPTION_INPUT_DESC[2]="use lowercase"
DOMAIN_OPTION_INPUT_DESC[3]="To print text from the value of -t"

# Implementation of "hello" command
# 
# DOMAIN_OPTION_VALUE[] is an array managed by the template base.sh
# The number of array items of DOMAIN_OPTION_VALUE[] will be identical to DOMAIN_OPTION_NAME[].
# Possible values on each data type: 
# 
#   Possible values of string data type  =  { "<undefined>" , ... }
#   Possible values of boolean data type =  { 0 , 1 }
#   Possible values of cmd data type     =  { "wait" , "invoked" }
# 
hello() {
    # -t | --text
    TEXT=${DOMAIN_OPTION_VALUE[0]}
    # -u | --uppercase
    ENABLED_UPPERCASE=${DOMAIN_OPTION_VALUE[1]}
    if [ ${ENABLED_UPPERCASE} == true ]; then
        echo ${TEXT} | tr '[:lower:]' '[:upper:]'
        exit
    fi 
    # -l | --lowercase
    ENABLED_LOWERCASE=${DOMAIN_OPTION_VALUE[2]}
    if [ ${ENABLED_LOWERCASE} == true ]; then
        echo ${TEXT} | tr '[:upper:]' '[:lower:]'
        exit
    fi 

    echo ${TEXT}
    exit
}

source ../base.sh