/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup";

static char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* time in seconds before the monitor shuts down */
static int monitortime = 5;

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* time in seconds to cancel lock with mouse movement */
static int timetocancel = 4;

/* default message */
static const char * message = "Password, please";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static char * font_name = "6x10";

/*Enable blur*/
#define BLUR
/*Set blur radius*/
static int blurRadius=5;
/*Enable Pixelation*/
//#define PIXELATION
/*Set pixelation radius*/
static int pixelSize=0;

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "color0",       STRING,  &colorname[INIT] },
		{ "color4",       STRING,  &colorname[INPUT] },
		{ "color1",       STRING,  &colorname[FAILED] },
		{ "foreground",   STRING,  &text_color },
		{ "font_name",    STRING,  &font_name },
        { "monitortime",  INTEGER, &monitortime },
        { "timetocancel", INTEGER, &timetocancel },
        { "blurRadius",   INTEGER, &blurRadius },
        { "pixelSize",    INTEGER, &pixelSize },
};

