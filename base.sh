#! /bin/bash
# Bash shell script template for readability CLI
# https://github.com/vorachet/bash-cli-template
# MIT License 
# Tested with GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin15)

BASH_CLI_ALL_ARGS=${@:2}
BASH_CLI_CURRENT_CMD_INDEX=0

for i in "${!BASH_CLI_OPT_NAME[@]}"
do
      if [ ! "${BASH_CLI_OPT_DATA_TYPE[$i]}"  ];  then
            echo "BASH_CLI_OPT_DATA_TYPE[$i]=\"\" empty string is not allowed."
            echo "The value must be one of these: \"string\", \"boolean\", or \"cmd\""
            exit
      else 
            if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "string" ] ; then 
                  BASH_CLI_OPT_VALUE[$i]="<undefined>"
            elif [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "boolean" ] ; then 
                  BASH_CLI_OPT_VALUE[$i]=false
            elif [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "cmd" ] ; then 
                  BASH_CLI_OPT_VALUE[$i]="wait"
            else 
                  echo "BASH_CLI_OPT_DATA_TYPE[$i]=${BASH_CLI_OPT_DATA_TYPE[$i]} is not allowed."
                  echo "The value must be one of these: \"string\", \"boolean\", or \"cmd\""
                  exit
            fi   
      fi
done

SPECLINES=""
for i in "${!BASH_CLI_OPT_NAME[@]}"
do
      if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" != "cmd" ];  then
            SPECLINES+=" \t[${BASH_CLI_OPT_NAME[$i]}|${BASH_CLI_OPT_ALT_NAME[$i]} <${BASH_CLI_OPT_DESC[$i]}>]\n"
      fi         
done
SPECLINES+=" \t[-h|--help]\n"

SCRIPT_OPTIONS=""
SCRIPT_CMDS=""
for i in "${!BASH_CLI_OPT_DATA_TYPE[@]}"
do
      if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" != "cmd" ];  then
            SCRIPT_OPTIONS="${SCRIPT_OPTIONS} 
                              \t    ${BASH_CLI_OPT_NAME[$i]} \n"
      else 

            SCRIPT_CMDS="${SCRIPT_CMDS} 
                              \t${BASH_CLI_OPT_NAME[$i]} | ${BASH_CLI_OPT_ALT_NAME[$i]}
                              \t    ${BASH_CLI_OPT_DESC[$i]} \n"
      fi
done

function help {
      echo -e "\n Usage: ./${BASH_CLI_SCRIPT_NAME} \n\n ${SPECLINES}
            \tThese are common ${BASH_CLI_SCRIPT_NAME} commands used in various situations:
            ${SCRIPT_CMDS}
      "
}
 
if [ $# -eq 0  ];  then
      help
      exit
fi

while [ "$1" != "" ]; do
      for i in ${!BASH_CLI_OPT_NAME[@]}
      do
            if [[ ( "${BASH_CLI_OPT_NAME[$i]}" == "$1" ) ||  
                  ( "${BASH_CLI_OPT_ALT_NAME[$i]}" == "$1" ) ]] ; then
                  if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "string" ] ; then 
                        if [[ ( ${2:0:1} == "-" ) || ( ${2:0:1} == "") ]] ; then 
                              BASH_CLI_OPT_VALUE[$i]='<undefined>'
                        else  
                              BASH_CLI_OPT_VALUE[$i]=$2 
                              shift
                        fi
                  fi   

                  if [ ${BASH_CLI_OPT_DATA_TYPE[$i]} == "boolean" ] ; then 
                        BASH_CLI_OPT_VALUE[$i]=true
                  fi 

                  if [ ${BASH_CLI_OPT_DATA_TYPE[$i]} == "cmd" ] ; then 
                        BASH_CLI_OPT_VALUE[$i]="invoked"
                  fi 
  
            else 
                  if [[ ( "$1" == "-h" ) || ( "$1" == "--help" ) ]] ; then
                        help
                        exit
                  fi

            fi
      done
      shift
done

validate_mandatory_options(){
      local i
      for i in $(echo ${BASH_CLI_MANDATORY_PARAM[$BASH_CLI_CURRENT_CMD_INDEX]} | tr "," "\n")
      do
            if [ "${BASH_CLI_OPT_DATA_TYPE[$i]}" == "boolean" ];  then
                  echo -e "\n Warning!! \n"
                  echo -e "\t Please check your script implementation" 
                  echo -e "\t All mandatory options (BASH_CLI_MANDATORY_PARAM[]) must be configured with string datatype option"
                  echo -e "\t BASH_CLI_OPT_NAME[$i]=\"${BASH_CLI_OPT_NAME[$i]}\" is currently using boolean data type and it does not allow to be a mandatory option"
                  echo -e "\n"
                  exit
            fi
            validate_string_parameter "${BASH_CLI_OPT_NAME[$i]}" "${BASH_CLI_OPT_VALUE[$i]}" "${BASH_CLI_OPT_DATA_TYPE[$i]}" "${BASH_CLI_OPT_DESC[$i]}"
      done
}

validate_string_parameter() {
      local pname=$1
      local pvalue=$2
      local pdatatype=$3
      local pdesc=$4
      if [ "${pvalue}" == "<undefined>" ];  then
            echo -e "\t\tMissing mandatory option: \"${pname}\" (${pdesc}) is mandatory option"

            if [ "${pdatatype}" == "string" ];  then
                  echo -e "\t\tExample: ./${BASH_CLI_SCRIPT_NAME} ${BASH_CLI_OPT_NAME[$BASH_CLI_CURRENT_CMD_INDEX]} ${pname} \"String Value\" "
            fi
            exit
      fi
}

show_optional_parameters() {
      local i
      local options
      for i in $(echo "${BASH_CLI_NON_MANDATORY_PARAM[$BASH_CLI_CURRENT_CMD_INDEX]}" | tr "," "\n")
      do
            options="${options} ${BASH_CLI_OPT_NAME[$i]}" 
      done
      echo -e "\n\tAll optional parameters of this command: ${options}"

      echo -e "\tCurrent value:"
      for i in $(echo ${BASH_CLI_NON_MANDATORY_PARAM[$BASH_CLI_CURRENT_CMD_INDEX]} | tr "," "\n")
      do
            echo -e "\t\t${BASH_CLI_OPT_NAME[$i]} ${BASH_CLI_OPT_VALUE[$i]}"
      done       
}

process() {
      local j

      for j in "${!BASH_CLI_OPT_NAME[@]}"
      do
            if [ "${BASH_CLI_OPT_DATA_TYPE[$j]}" == "cmd" ];  then
                  if [ "${BASH_CLI_OPT_VALUE[$j]}" == "invoked" ];  then
                        BASH_CLI_CURRENT_CMD_INDEX=$j
                        validate_mandatory_options
                        ${BASH_CLI_OPT_NAME[$BASH_CLI_CURRENT_CMD_INDEX]} 
                        # ${BASH_CLI_OPT_NAME[$BASH_CLI_CURRENT_CMD_INDEX]} "${BASH_CLI_ALL_ARGS}"
                        break
                  fi
                  
            fi
      done
}

process $BASH_CLI_ALL_ARGS

