//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"",	"~/.local/bin/dwmblocks/newpackages | xargs printf ' %s'",	900,	8},
	{"墳",	"~/.local/bin/dwmblocks/volume | xargs printf ' %s'",	0,	10},
	{"",	"~/.local/bin/dwmblocks/battery | xargs printf ' %s'",	5,	0},
	{"",	"date '+%H:%M%p' | xargs printf ' %s'",	60,	0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 1;
