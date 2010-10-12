#!/bin/sh
Source=`cat "%%%{PBXFilePath}%%%"`
SelectionStart="%%%{PBXSelectionStart}%%%"
SelectionEnd="%%%{PBXSelectionEnd}%%%"
if [ %%%{PBXSelectionLength}%%% -gt 0 ]
  then
    echo "This does not work if you select text. Put your cursor inside a String." >&2
    exit
fi
BOOL=1
StringStart=$SelectionStart
StringStop=$SelectionEnd

while [ $BOOL -eq 1 ]
do
  tmpText=`echo "${Source:${StringStart}:1}"`
  if [ "$tmpText" = "@" ]
    then 
      BOOL=0
    else 
      StringStart=$(($StringStart - 1))
  fi
done
BOOL=1
while [ $BOOL -eq 1 ]
do 
  tmpText=`echo "${Source:${StringStop}:1}"`
  if [ "$tmpText" = "\"" ]
    then 
      BOOL=0
  fi   
  StringStop=$(($StringStop + 1))
done

StringToReplace=`echo ${Source:${StringStart}:$(($StringStop - $StringStart))}`
ReplacementString="NSLocalizedString($StringToReplace,nil)"
echo -n "${Source:0:${StringStart}}"
echo -n "$ReplacementString"
echo -n "${Source:${StringStop}}"
