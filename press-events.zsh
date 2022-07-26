
getKey(){
  oldSttySettings=`stty -g`
  stty -echo raw
  echo "`dd count=1 2> /dev/null`"
  stty $oldSttySettings
  
}

getMouse(){
}
