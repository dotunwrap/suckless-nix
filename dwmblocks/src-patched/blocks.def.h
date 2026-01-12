
//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "\
    export VAL=\"$(echo -n \"$(upower -b | sed -n 's/.*percentage:[[:space:]]*\\([0-9]\\+\\).*/\\1/p')\")\" \n \
    export OUT=\"$(echo -n \"$(upower -b | sed -n 's/.*state:[[:space:]]*\\(.*\\)/\\1/p')\")\" \n \
    export BAT_ARR=('󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹') \n \
    case $OUT in \n \
    \"discharging\") echo -n \"${BAT_ARR[$((VAL / 10))]}\";; \n \
    \"pending-charge\") echo -n '󰂑';; \n \
    \"charging\") echo -n \"󱐋${BAT_ARR[$((VAL / 10))]}\";; \n \
    \"fully-charged\") echo -n '󱟢';; \n \
    *) [ -n \"$VAL\" ] && echo 'none';; \n \
    esac \n \
    [ -n \"$VAL\" ] && echo \" $VAL%\" \n ",	1,		0},
	{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"", "date '+%b %d (%a) %I:%M%p'",					5,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
