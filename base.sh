#! /bin/bash
# bash-cli-template
# Bash v3.x shell script template for command-line interfaces.
# https://github.com/vorachet/bash-cli-template
# MIT License 

ALL_PARAMS=$@
DEBUG=false
CURRENT_CMD_INDEX=0

for i in ${!DOMAIN_OPTION_NAME[@]}
do
      if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "" ];  then
            DOMAIN_OPTION_DATA_TYPE[$i]="string"
      fi

      if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "string" ] ; then 
            DOMAIN_OPTION_VALUE[$i]="<undefined>"
      fi   

      if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "boolean" ] ; then 
            DOMAIN_OPTION_VALUE[$i]=false
      fi

      if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "cmd" ] ; then 
            DOMAIN_OPTION_VALUE[$i]="wait"
      fi   
done

SPECLINES=""
for i in ${!DOMAIN_OPTION_NAME[@]}
do
      if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} != "cmd" ];  then
            SPECLINES="${SPECLINES} \t[${DOMAIN_OPTION_NAME[$i]}|${DOMAIN_OPTION_ALTERNATIVE_NAME[$i]} <${DOMAIN_OPTION_INPUT_DESC[$i]}>]\n"
      fi         
done
SPECLINES="${SPECLINES}\t[-d|--debug]\n"
SPECLINES="${SPECLINES}\t[-h|--help]\n"

SCRIPT_OPTIONS=""
SCRIPT_CMDS=""
for i in ${!DOMAIN_OPTION_DATA_TYPE[@]}
do
      if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} != "cmd" ];  then
            SCRIPT_OPTIONS="${SCRIPT_OPTIONS} 
                              \t\t${DOMAIN_OPTION_NAME[$i]}  
                              \tEx. ${DOMAIN_OPTION_INPUT_EXAMPLE[$i]}\n
                              \t\t 
                              \tNotes: ${DOMAIN_OPTION_INPUT_NOTES[$i]}\n"
      else 
            MANDATORY_OPS=""                  
            for mp in "${DOMAIN_CMD_MANDATORY_OPTIONS[@]}"
            do
                  for imp in $(echo ${mp} | tr "," "\n")
                  do
                        MANDATORY_OPS="${MANDATORY_OPS} ${DOMAIN_OPTION_NAME[$imp]}"
                  done
            done

            OPTIONAL_OPS=""                  
            for op in ${DOMAIN_CMD_OPTIONS[@]}
            do
                  for iop in $(echo ${op} | tr "," "\n")
                  do
                        OPTIONAL_OPS="${OPTIONAL_OPS} ${DOMAIN_OPTION_NAME[$iop]}"
                  done
            done

            SCRIPT_CMDS="${SCRIPT_CMDS} 
                              \t${DOMAIN_OPTION_NAME[$i]} | ${DOMAIN_OPTION_ALTERNATIVE_NAME[$i]} \n\n
                              \t\t${DOMAIN_OPTION_INPUT_DESC[$i]} \n
                              \n\t\tMandatory parameters: ${MANDATORY_OPS}    
                              \n\t\tOptional parameters: ${OPTIONAL_OPS}    \n\n"
      fi
done

function help {
      local HELP="\n
            Usage: ./${SCRIPT_NAME} \n
                   ${SPECLINES}
            \n
            \tThese are common ${SCRIPT_NAME} commands used in various situations:\n\n
            ${SCRIPT_CMDS}
      "
      echo -e ${HELP}
}

if [ "$1" == "" ];  then
      help
      exit
fi

while [ "$1" != "" ]; do
      for i in ${!DOMAIN_OPTION_NAME[@]}
      do
            if [[ ( ${DOMAIN_OPTION_NAME[$i]} == $1 ) ||  
                  ( ${DOMAIN_OPTION_ALTERNATIVE_NAME[$i]} == $1 ) ]] ; then
                  if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "string" ] ; then 
                        if [[ ( ${2:0:1} == "-" ) || ( ${2:0:1} == "") ]] ; then 
                              DOMAIN_OPTION_VALUE[$i]='<undefined>'
                        else  
                              DOMAIN_OPTION_VALUE[$i]=$2 
                              shift
                        fi
                  fi   

                  if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "boolean" ] ; then 
                        DOMAIN_OPTION_VALUE[$i]=true
                  fi 

                  if [ ${DOMAIN_OPTION_DATA_TYPE[$i]} == "cmd" ] ; then 
                        DOMAIN_OPTION_VALUE[$i]="invoked"
                  fi 
  
            else 
                  if [[ ( "$1" == "-d" ) || ( "$1" == "--debug" ) ]] ; then
                        DEBUG=true
                  fi

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
      if [ $DEBUG == true ];  then 
            echo -e "\tChecking mandatory parameters"
      fi

      for i in $(echo ${DOMAIN_CMD_MANDATORY_OPTIONS[$CURRENT_CMD_INDEX]} | tr "," "\n")
      do
            validate_string_parameter "${DOMAIN_OPTION_NAME[$i]}" "${DOMAIN_OPTION_ALTERNATIVE_NAME[$i]}"  "${DOMAIN_OPTION_VALUE[$i]}"
      done
      
      if [ $DEBUG == true ];  then
            show_optional_parameters
            echo -e "\n"
      fi
}

validate_string_parameter() {
      local psname=$1
      local ptname=$2
      local pvalue=$3
      if [ ${pvalue} == "<undefined>" ];  then
            echo -e "\t\t${psname}|${ptname}  (Not Found)"
            echo -e "\t\tUsage: \"${psname}|${ptname}\" is mandatory option"
            exit
      else 
             if [ $DEBUG == true ];  then 
                  echo -e "\t\t${psname} ${pvalue}  (OK)"
            fi
      fi
}

show_optional_parameters() {
      local i
      local options=""
      for i in $(echo ${DOMAIN_CMD_OPTIONS[$CURRENT_CMD_INDEX]} | tr "," "\n")
      do
            options="${options} ${DOMAIN_OPTION_NAME[$i]}" 
      done
      echo -e "\n\tAll optional parameters of this command: ${options}"

      echo -e "\tCurrent value:"
      for i in $(echo ${DOMAIN_CMD_OPTIONS[$CURRENT_CMD_INDEX]} | tr "," "\n")
      do
            echo -e "\t\t${DOMAIN_OPTION_NAME[$i]} ${DOMAIN_OPTION_VALUE[$i]}"
      done       
}

process() {
      local i
      local j

      if [ $DEBUG == true ];  then
            echo -e "\n\t*********** DEBUG ***********"
            echo -e "\t-d | --debug = ${DEBUG}"
            for i in ${!DOMAIN_OPTION_NAME[@]}
            do
                   echo -e "\t${DOMAIN_OPTION_NAME[$i]} | ${DOMAIN_OPTION_ALTERNATIVE_NAME[$i]} = ${DOMAIN_OPTION_VALUE[$i]}"
            done            
            echo -e "\t*********** DEBUG ***********"
      fi

      for j in ${!DOMAIN_OPTION_NAME[@]}
      do
            if [ ${DOMAIN_OPTION_DATA_TYPE[$j]} == "cmd" ];  then
                  if [ ${DOMAIN_OPTION_VALUE[$j]} == "invoked" ];  then

                        if [ $DEBUG == true ];  then
                              echo -e "\ninvoking (${DOMAIN_OPTION_NAME[$j]} | ${DOMAIN_OPTION_ALTERNATIVE_NAME[$j]}) command...\n"
                        fi

                        CURRENT_CMD_INDEX=$j
                        validate_mandatory_options
                        ${DOMAIN_OPTION_NAME[$CURRENT_CMD_INDEX]} 
                        break
                  fi
                  
            fi
      done
}

process 

