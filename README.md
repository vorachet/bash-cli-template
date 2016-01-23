
# Bash shell script template for readability CLI


![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/demo.gif)


# Features

 * **bash-cli-template** allows you writing a readability CLI script 
 * **bash-cli-template** provides built-in validation for mandatory and optional command parameters
 * **bash-cli-template** eases the script user can understand command usage with built-in readability CLI flow.
 * **bash-cli-template** provides built-in debug and help command
 * **bash-cli-template** provides easy steps to define commands and to implement the body of your command execution

# Learning by example

## Running script example

The script example is available in folder "examples". You can run "helloworld.sh" with the following steps.

```
$ git clone https://github.com/vorachet/bash-cli-template.git
$ cd bash-cli-template/examples
$ ./helloworld.sh
```


###  First CLI script with **bash-cli-template**

The finished code is available in examples folder

File: helloworld.sh
```
#!/bin/bash

# Implementation of helloword script 

# Script name
BASH_CLI_SCRIPT_NAME="helloworld.sh"

# Option name
BASH_CLI_OPT_NAME[0]="-t"
BASH_CLI_OPT_NAME[1]="-u"
BASH_CLI_OPT_NAME[2]="-l"
BASH_CLI_OPT_NAME[3]="hello"

# Alternative option name
BASH_CLI_OPT_ALT_NAME[0]="--text"
BASH_CLI_OPT_ALT_NAME[1]="--uppercase"
BASH_CLI_OPT_ALT_NAME[2]="--lowercase"
BASH_CLI_OPT_ALT_NAME[3]="helloworld" 

# Data type consists of string, boolean, and cmd.
#   - string does not allow you set empty option value
#   - object allows you flag the option without giving value
#   - cmd is the command used in various situations in your script. 
BASH_CLI_OPT_DATA_TYPE[0]="string"
BASH_CLI_OPT_DATA_TYPE[1]="boolean"
BASH_CLI_OPT_DATA_TYPE[2]="boolean"
BASH_CLI_OPT_DATA_TYPE[3]="cmd"

# Setting mandatory and optional parameters for cmd "hello"
# A cmd data type may require one or more mandatory and optional parameters
#
# Requirements of hellworld.sh
#
# "-t | --text" is a mandatory parameter of the cmd "hello"
# "-u | --uppercase" is an optional parameter of the cmd "hello"
# "-l | --lowercase" is an optional parameter of the cmd "hello"
#
# Reference numbers
#
# The index reference number of BASH_CLI_OPT_NAME[3]="hello" is 3
# The array index of BASH_CLI_OPT_NAME[0]="-t" is 0
# The array index of BASH_CLI_OPT_NAME[1]="-u" is 1
# The array index of BASH_CLI_OPT_NAME[2]="-l" is 2

# BASH_CLI_OPT_NAME[3]="hello" requires BASH_CLI_OPT_NAME[0]="-t" as mandatory parameter
BASH_CLI_MANDATORY_PARAM[3]="0"
# BASH_CLI_OPT_NAME[3]="hello" requires BASH_CLI_OPT_NAME[1]="-u" 
# and BASH_CLI_OPT_NAME[2]="-l" as optional parameter
BASH_CLI_NON_MANDATORY_PARAM[3]="1,2"

# Setting description of the option
BASH_CLI_OPT_DESC[0]="text"
BASH_CLI_OPT_DESC[1]="use uppercase"
BASH_CLI_OPT_DESC[2]="use lowercase"
BASH_CLI_OPT_DESC[3]="To print text from the value of -t"

# Implementation of "hello" command
# 
# Getting parameter values
# 
# BASH_CLI_OPT_VALUE[] is an array variable that declared by the template base.sh
# The value of BASH_CLI_OPT_VALUE[] will be managed by the template
# 
hello() {
    # -t | --text
    local text=${BASH_CLI_OPT_VALUE[0]}
    # -u | --uppercase
    local enabled_uppercase=${BASH_CLI_OPT_VALUE[1]}
    # -l | --lowercase
    local enabled_lowercase=${BASH_CLI_OPT_VALUE[2]}

    if [ ${enabled_uppercase} == true ]; then
        echo "${text}" | tr '[:lower:]' '[:upper:]'
    elif [ ${enabled_lowercase} == true ]; then
        echo "${text}" | tr '[:upper:]' '[:lower:]'
    else 
        echo "${text}" 
    fi 

    exit
}

source ../base.sh

``` 

# License 

The MIT License (MIT)

Copyright (c) 2015 Vorachet Jaroensawas 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
