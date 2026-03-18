ICON=""
MEM_INFO=$(free -h | awk '/^Mem/ { print $3"/"$2 }' | sed s/i//g)

echo "$ICON $MEM_INFO"
