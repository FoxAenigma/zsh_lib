surf(){
  
  #Setting variables
  source ~/repo/projects/zsh_lib/press-events.zsh

  local MOD=""
  local DIRARRAY
  local SEL
  local COLOR=97
  local KEY

  #Gettind mod
  if [[ -v 1 ]]
  then
    MOD=$1
  fi
  
  #Getting dir directory and array
  getArray(){
    SEL=0
    if [[ "$MOD" = "-a" ]]
    then
      DIRARRAY=($(find . -maxdepth 1 -type d | sed 's/.\///' | awk '{print $1"/"}'))
    else
      DIRARRAY=($(ls -d */))
    fi
  }
  
  #Drawing screen
  drawArray(){

    SEL=$1
    setColor(){ 
      if [[ $SEL = $2 ]] then
        printf "\e[48;5;$1m" 
      fi
    }
    endColor(){ printf "\e[0m" }
    
    echo "from $PWD"
    echo "|"

     
    setColor $COLOR 0 
    echo "|=====> STOP"
    endColor
    
    setColor $COLOR 1
    echo "|-----> Back <-"

    endColor
    for (( i=1; i<${#DIRARRAY[@]}; i++ ))
      do
      setColor $COLOR i
      echo "|-----> ${DIRARRAY[i]}"
      endColor
    done

  }

  listenKey(){
    KEY=$(getKey)
    
    #KEY case
    if [[ $KEY = "\e[A" ]] 
    then
      $((SEL++))
      echo $SEL
    elif [[ $KEY = "\e[B" ]] 
    then
      $((SEL++))
    else
      echo "$SEL"
    fi
    
    #SEL resize
    if [[ $SEL > ${#DIRARRAY[@]} ]] then
      SEL=${#DIRARRAY[@]}
    elif [[ $SEL < 0 ]] then
      SEL=0
    fi
  }

  #Drawing selector
 # drawSelector(){
#
  #}


  #Main recursive-loop
  getArray
  while [[ $SEL != -1 ]] do
    drawArray
    listenKey
  done
}
