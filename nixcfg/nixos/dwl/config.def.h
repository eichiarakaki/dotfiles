/* See LICENSE file for copyright and license details. */

/* ------------------------------------------------------------
 * Helpers
 * ------------------------------------------------------------ */

/* RGBA hex -> float color helper */
#define COLOR(hex) { \
	((hex >> 24) & 0xFF) / 255.0f, \
	((hex >> 16) & 0xFF) / 255.0f, \
	((hex >> 8) & 0xFF) / 255.0f, \
	(hex & 0xFF) / 255.0f \
}

/* shell helper */
#define SHCMD(cmd) { .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL } }

/* ------------------------------------------------------------
 * Appearance
 * ------------------------------------------------------------ */

static const int sloppyfocus = 1;
static const int bypass_surface_visibility = 0;

static const unsigned int borderpx = 1;


static const float rootcolor[]   = COLOR(0x222222ff);
static const float bordercolor[] = COLOR(0x444444ff);
static const float focuscolor[]  = COLOR(0x005577ff);
static const float urgentcolor[] = COLOR(0xff0000ff);

static const float fullscreen_bg[] = { 0.0, 0.0, 0.0, 1.0 };

/* ------------------------------------------------------------
 * Tags
 * ------------------------------------------------------------ */

#define TAGCOUNT 9

/* ------------------------------------------------------------
 * Logging
 * ------------------------------------------------------------ */

static int log_level = WLR_ERROR;

/* ------------------------------------------------------------
 * Rules
 * ------------------------------------------------------------ */

static const Rule rules[] = {
	/* app_id, title, tags mask, isfloating, monitor */
	{ NULL, NULL, 0, 0, -1 },
};

/* ------------------------------------------------------------
 * Layouts
 * ------------------------------------------------------------ */

static const Layout layouts[] = {
	/* symbol arrange */
	{ "[]=", tile },
	{ "><>", NULL },
	{ "[M]", monocle },
};

/* ------------------------------------------------------------
 * Monitor rules
 * ------------------------------------------------------------ */

static const MonitorRule monrules[] = {
	{ NULL, 0.55f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
};

/* ------------------------------------------------------------
 * Keyboard
 * ------------------------------------------------------------ */

static const struct xkb_rule_names xkb_rules = {
	.options = NULL,
};

static const int repeat_rate = 50;
static const int repeat_delay = 200;

/* ------------------------------------------------------------
 * Input
 * ------------------------------------------------------------ */

static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;

static const int natural_scrolling = 0;
static const int disable_while_typing = 1;

static const int left_handed = 0;
static const int middle_button_emulation = 0;

static const enum libinput_config_scroll_method scroll_method =
	LIBINPUT_CONFIG_SCROLL_2FG;

static const enum libinput_config_click_method click_method =
	LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

static const uint32_t send_events_mode =
	LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

static const enum libinput_config_accel_profile accel_profile =
	LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;

static const double accel_speed = 0.0;

static const enum libinput_config_tap_button_map button_map =
	LIBINPUT_CONFIG_TAP_MAP_LRM;

/* Alt key as modifier */
#define MODKEY WLR_MODIFIER_ALT

/* ------------------------------------------------------------
 * Commands
 * ------------------------------------------------------------ */

static const char *termcmd[] = {
	"foot",
	NULL
};

static const char *menucmd[] = {
	"wmenu-run",
	NULL
};

static const char *screenshotcmd[] = {
	"/bin/sh", "-c",
	"grim -g \"$(slurp)\" - | wl-copy",
	NULL
};

static const char *fullscreenshotcmd[] = {
	"/bin/sh", "-c",
	"grim - | wl-copy",
	NULL
};

static const char *nightmodecmd[] = {
	"/bin/sh", "-c",
	"pkill gammastep; gammastep -O 3300",
	NULL
};

static const char *daymodecmd[] = {
	"/bin/sh", "-c",
	"pkill gammastep",
	NULL
};

/* ------------------------------------------------------------
 * Tags macro
 * ------------------------------------------------------------ */

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY, KEY, view, {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL, KEY, toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY, tag, {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT, SKEY, toggletag, {.ui = 1 << TAG} }

/* ------------------------------------------------------------
 * Keybindings
 * ------------------------------------------------------------ */

static const Key keys[] = {
	/* launcher */
	{ MODKEY, XKB_KEY_p, spawn, {.v = menucmd} },

	/* terminal */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return, spawn, {.v = termcmd} },

	/* focus stack */
	{ MODKEY, XKB_KEY_j, focusstack, {.i = +1} },
	{ MODKEY, XKB_KEY_k, focusstack, {.i = -1} },

	/* layout sizing */
	{ MODKEY, XKB_KEY_h, setmfact, {.f = -0.05f} },
	{ MODKEY, XKB_KEY_l, setmfact, {.f = +0.05f} },

	/* master */
	{ MODKEY, XKB_KEY_i, incnmaster, {.i = +1} },
	{ MODKEY, XKB_KEY_d, incnmaster, {.i = -1} },

	/* swap focused with master */
	{ MODKEY, XKB_KEY_Return, zoom, {0} },

	/* layouts */
	{ MODKEY, XKB_KEY_t, setlayout, {.v = &layouts[0]} },
	{ MODKEY, XKB_KEY_f, setlayout, {.v = &layouts[1]} },
	{ MODKEY, XKB_KEY_m, setlayout, {.v = &layouts[2]} },

	/* cycle layout */
	{ MODKEY, XKB_KEY_space, setlayout, {0} },

	/* toggle floating window */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space, togglefloating, {0} },

	/* fullscreen */
	{ MODKEY, XKB_KEY_e, togglefullscreen, {0} },

	/* close focused window */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_c, killclient, {0} },

	/* quit dwl */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_q, quit, {0} },

	/* screenshots */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_s, spawn, {.v = screenshotcmd} },
	{ 0, XKB_KEY_Print, spawn, {.v = fullscreenshotcmd} },

	/* gammastep */
	{ MODKEY, XKB_KEY_n, spawn, {.v = nightmodecmd} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_n, spawn, {.v = daymodecmd} },

	/* tags */
	TAGKEYS(XKB_KEY_1, XKB_KEY_exclam, 0),
	TAGKEYS(XKB_KEY_2, XKB_KEY_at, 1),
	TAGKEYS(XKB_KEY_3, XKB_KEY_numbersign, 2),
	TAGKEYS(XKB_KEY_4, XKB_KEY_dollar, 3),
	TAGKEYS(XKB_KEY_5, XKB_KEY_percent, 4),
	TAGKEYS(XKB_KEY_6, XKB_KEY_asciicircum, 5),
	TAGKEYS(XKB_KEY_7, XKB_KEY_ampersand, 6),
	TAGKEYS(XKB_KEY_8, XKB_KEY_asterisk, 7),
	TAGKEYS(XKB_KEY_9, XKB_KEY_parenleft, 8),

	/* all tags */
	{ MODKEY, XKB_KEY_0, view, {.ui = ~0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_parenright, tag, {.ui = ~0} },
};

/* ------------------------------------------------------------
 * Mouse
 * ------------------------------------------------------------ */

static const Button buttons[] = {
	/* move floating window */
	{ MODKEY, BTN_LEFT, moveresize, {.ui = CurMove} },

	/* toggle floating */
	{ MODKEY, BTN_MIDDLE, togglefloating, {0} },

	/* resize floating window */
	{ MODKEY, BTN_RIGHT, moveresize, {.ui = CurResize} },
};
