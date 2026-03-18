// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.

static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", SCRIPT_PATH "/weather.sh", 1800, 0},
    {"", SCRIPT_PATH "/memory.sh", 30, 0},
    {"", SCRIPT_PATH "/network.sh", 5, 0},
    {"", SCRIPT_PATH "/audio.sh", 1, 0},
    {"", SCRIPT_PATH "/battery.sh", 1, 0},
    {"", SCRIPT_PATH "/datetime.sh", 5, 0},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = "  ";
static unsigned int delimLen = 2;
