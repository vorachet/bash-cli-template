
# Bash shell script template for readability CLI


![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/demo.gif)


# Features

 * **bash-cli-template** allows you writing a readability CLI script 
 * **bash-cli-template** provides built-in validation for mandatory and optional command parameters
 * **bash-cli-template** eases the script user can understand command usage with built-in readability CLI flow.
 * **bash-cli-template** provides built-in debug and help command
 * **bash-cli-template** provides easy steps to define commands and to implement the body of your command execution

# Learning by example

## helloworld CLI script  

### Running script example

The script example is available in folder "examples". You can run "helloworld.sh" with the following steps.

```
$ git clone https://github.com/vorachet/bash-cli-template.git
$ cd bash-cli-template/examples
$ ./helloworld.sh
```

###  A quick walk through the CLI 

Let us see capabilities of the CLI example before learn to write your first CLI with **bash-cli-template**. 

##### Command usage of CLI

![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/1.jpg)

##### Inspecting CLI options and commands

![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/2.jpg)

##### Built-in validator for mandatory options validation

![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/3.jpg)

Both option name and value will be validated by the built-in validator.

![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/4.jpg)

If the user missing mandatory options, CLI will be stopped and drop an error message. 

##### Inspecting command options 

If all mandatory options are valid and debug mode is specified, the script will give the aid of command usage. 

![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/5.jpg)

When the user run the script without debug mode

![Logo](https://github.com/vorachet/bash-cli-template/raw/master/screenshot/6.jpg)

Above pictures show interface capabilities that you can write a quality CLI script with zero scripting effort. Readability and validation are built-in in **bash-cli-template**.

###  Skimming script example (helloworld CLI script) 

This is the complete source of helloworld.sh.  Let you skimming the script example and go to read implementation guide in the next section.

File: helloworld.sh
```
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
DOMAIN_OPTION_DATA_TYPE[0]="string"
DOMAIN_OPTION_DATA_TYPE[1]="boolean"
DOMAIN_OPTION_DATA_TYPE[2]="boolean"
DOMAIN_OPTION_DATA_TYPE[3]="cmd"

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
# DOMAIN_OPTION_VALUE[] is an array variable managed by base.sh
# The number of array items of DOMAIN_OPTION_VALUE[] are identical to DOMAIN_OPTION_NAME[].
# 
hello() {
    # -t | --text
    TEXT=${DOMAIN_OPTION_VALUE[0]}

    if [ "${TEXT}" == "Hello" ]; then
        TEXT="Sawasdee!"
    fi

    if [ "${TEXT}" == "Sawasdee" ]; then
        TEXT="Hello!"
    fi

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

``` 

### Steps to write your own CLI script with bash-cli-template

**bash-cli-template** comes with **base.sh**. **base.sh** manages all interface works for you. **bash-cli-template** can understand your command definitions with following steps.

#### Define the following variables in your script

 1. SCRIPT_NAME
 2. DOMAIN_OPTION_NAME[]
 3. DOMAIN_OPTION_ALTERNATIVE_NAME[]
 4. DOMAIN_OPTION_DATA_TYPE[]
 5. DOMAIN_CMD_MANDATORY_OPTIONS[]
 6. DOMAIN_CMD_OPTIONS[]
 7. DOMAIN_OPTION_INPUT_DESC[]

The command definition example in helloworld.sh.
```
SCRIPT_NAME="example1"
DOMAIN_OPTION_NAME[0]="-t"
DOMAIN_OPTION_NAME[1]="-u"
DOMAIN_OPTION_NAME[2]="-l"
DOMAIN_OPTION_NAME[3]="hello"
DOMAIN_OPTION_ALTERNATIVE_NAME[0]="--text"
DOMAIN_OPTION_ALTERNATIVE_NAME[1]="--uppercase"
DOMAIN_OPTION_ALTERNATIVE_NAME[2]="--lowercase"
DOMAIN_OPTION_ALTERNATIVE_NAME[3]="helloworld" 
DOMAIN_OPTION_DATA_TYPE[0]="string"
DOMAIN_OPTION_DATA_TYPE[1]="boolean"
DOMAIN_OPTION_DATA_TYPE[2]="boolean"
DOMAIN_OPTION_DATA_TYPE[3]="cmd"
DOMAIN_CMD_MANDATORY_OPTIONS[3]="0"
DOMAIN_CMD_OPTIONS[3]="1,2"
DOMAIN_OPTION_INPUT_DESC[0]="text"
DOMAIN_OPTION_INPUT_DESC[1]="use uppercase"
DOMAIN_OPTION_INPUT_DESC[2]="use lowercase"
DOMAIN_OPTION_INPUT_DESC[3]="To print text from the value of -t"
```

#### Declaring shell script function that corresponding to your command definition.

By looking the following command definition in helloworld.sh, the data type of the option "hello" is "cmd". This means "hello" option is a command. hello() function must be declared in your script. 

```
DOMAIN_OPTION_NAME[3]="hello"
DOMAIN_OPTION_DATA_TYPE[3]='cmd'
```

```
hello() {
  # the implementation of hello command    
}
```

#### Implementing the body of your command

In order to implement the body of the hello() function, the following variables are allowed to use inside the hello() function. 

```
DOMAIN_OPTION_VALUE[0]
DOMAIN_OPTION_VALUE[1]
DOMAIN_OPTION_VALUE[2]
```

 * DOMAIN_OPTION_VALUE[0] is the string value of (-t|--text). It will be assigned by base.sh before calling hello()
 * DOMAIN_OPTION_VALUE[1] is the boolean value of (-u|--uppercase). It will be assigned by base.sh before calling hello()
 * DOMAIN_OPTION_VALUE[2] is the boolean value of (-l|--lowercase). It will be assigned by base.sh before calling hello()

DOMAIN_OPTION_VALUE[0] , DOMAIN_OPTION_VALUE[1], and DOMAIN_OPTION_VALUE[2] are important for hello() function becasue the following definitions.

```
DOMAIN_CMD_MANDATORY_OPTIONS[3]="0"
DOMAIN_CMD_OPTIONS[3]="1,2"
```

 * DOMAIN_CMD_MANDATORY_OPTIONS[3]="0"  means DOMAIN_OPTION_NAME[0]="-t" is mandatory parameter of hello command
 * DOMAIN_CMD_OPTIONS[3]="1,2" means DOMAIN_OPTION_NAME[1]="-u" and DOMAIN_OPTION_NAME[2]="-l" are optional parameter of hello command

#### Installing bash-cli-template

Add "source ./base.sh" at the end of your script

```
...

source ./base.sh
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
