// Modify this file to change what commands output to your statusbar, and
// recompile using the make command. #define SCRIPT_PATH "test"
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", SCRIPT_PATH "/network.sh", 5, 0},
    {"", SCRIPT_PATH "/battery.sh", 1, 0},
    {"", SCRIPT_PATH "/weather.sh", 1800, 0},
    {"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g", 30, 0},
    {"", "date '+%b %d (%a) %I:%M%p'", 5, 0},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
