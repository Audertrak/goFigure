-- global configuration
CREATE TABLE komorebi_static (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	crossBoundaryBehaviour TEXT CHECK(cross_boundary_behaviour IN ('Workspace', 'Monitor')), -- Behaviour when crossing monitor boundaries
    crossMonitorMoveBehaviour TEXT CHECK(cross_monitor_move_behaviour IN ('Swap', 'Insert', 'NoOp')), -- Behaviour when moving across monitor boundaries
    displayIndexPreferences TEXT, -- JSON or serialized representation of display index preferences
    floatOverride BOOLEAN, -- Enable or disable float override for new windows
    focusFollowsMouse TEXT CHECK(focus_follows_mouse IN ('Komorebi', 'Windows')), -- Focus follows mouse implementation
    ignoreRules TEXT, -- this needs form validation; maybe its own table?
    layeredApplications TEXT, -- JSON or serialized representation of layered applications
    defaultContainerPadding INTEGER, -- Global default container padding
    defaultWorkspacePadding INTEGER, -- Global default workspace padding
	global_workAreaOffset_bottom INTEGER, -- The bottom point in a Win32 Rect for global work area offset
    global_workAreaOffset_left INTEGER, -- The left point in a Win32 Rect for global work area offset
    global_workAreaOffset_right INTEGER, -- The right point in a Win32 Rect for global work area offset
    global_workAreaOffset_top INTEGER, -- The top point in a Win32 Rect for global work area offset

	-- foreign keys
	profileID INTEGER NOT NULL,
	komorebiVersion TEXT NOT NULL,
	FOREIGN KEY (profileID) REFERENCES profiles(id) ON DELETE CASCADE
	FOREIGN KEY (komorebiVersion) REFERENCES komorebiVersions(name),
);

CREATE TABLE komorebi_themes (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
);

CREATE TABLE komorebi_colors (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	borderColor_floating TEXT,
	borderColor_monocle TEXT,
	borderColor_single TEXT,
	borderColor_stack TEXT,
	borderColor_unfocused TEXT,
);

CREATE TABLE komorebi_animations (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	animationEnabled BOOLEAN,
	animationDuration INTEGER,
	animationFPS INTEGER,
	animationStyle TEXT CHECK(animation_style IN ('Linear', 'EaseInSine', 'EaseOutSine', 'EaseInOutSine', 'EaseInQuad', 'EaseOutQuad', 'EaseInOutQuad', 'EaseInCubic', 'EaseInOutCubic', 'EaseInQuart', 'EaseOutQuart', 'EaseInOutQuart', 'EaseInQuint', 'EaseOutQuint', 'EaseInOutQuint', 'EaseInExpo', 'EaseOutExpo', 'EaseInOutExpo', 'EaseInCirc', 'EaseOutCirc', 'EaseInOutCirc', 'EaseInBack', 'EaseOutBack', 'EaseInOutBack', 'EaseInElastic', 'EaseOutElastic', 'EaseInOutElastic', 'EaseInBounce', 'EaseOutBounce', 'EaseInOutBounce')),
);

CREATE TABLE komorebi_borders (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	border BOOLEAN,
	borderImplementation TEXT CHECK(border_implementation IN ('Komorebi', 'Windows')), -- Border implementation type
    borderOffset INTEGER, -- Offset of the window border
    borderStyle TEXT CHECK(border_style IN ('System', 'Rounded', 'Square')), -- Border style
    borderWidth INTEGER, -- Width of the window border
    borderZorder TEXT CHECK(border_z_order IN ('Top', 'NoTopMost', 'Bottom', 'TopMost')), -- Border z-order
    invisibleBorders_bottom INTEGER, -- The bottom point in a Win32 Rect for invisible borders
    invisibleBorders_left INTEGER, -- The left point in a Win32 Rect for invisible borders
    invisibleBorders_right INTEGER, -- The right point in a Win32 Rect for invisible borders
    invisibleBorders_top INTEGER, -- The top point in a Win32 Rect for invisible borders
);

-- monitor specific configuration
CREATE TABLE komorebi_monitors (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	monitorName TEXT,
	resolution TEXT,
	orientation TEXT CHECK(orientation IN('landscape', 'portrait'),
	workAreaOffset_bottom INTEGER,
	workAreaOffset_left INTEGER,
	workAreaOffset_right INTEGER,
	workAreaOffset_top INTEGER,
	windowBased_workAreaOffset_bottom INTEGER,
	windowBased_workAreaOffset_left INTEGER,
	windowBased_workAreaOffset_lright INTEGER,
	windowBased_workAreaOffset_top INTEGER,
);

-- workspace specific configuration
CREATE TABLE komorebi_workspaces (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT, -- Name of the workspace
    applyWindowBasedWorkAreaOffset BOOLEAN DEFAULT TRUE, -- Apply this monitor's window-based work area offset
    containerPadding INTEGER DEFAULT 10, -- Container padding (default: global)
    floatOverride BOOLEAN, -- Enable or disable float override
    layout TEXT CHECK(layout IN ('BSP', 'Columns', 'Rows', 'VerticalStack', 'HorizontalStack', 'UltrawideVerticalStack', 'Grid', 'RightMainVerticalStack')), -- Layout type
	laoutRules TEXT CHECK(layoutRules IN('BSP', 'Columns', 'Rows', 'VerticalStack', 'HorizontalStack', 'UltrawideVerticalStack', 'Grid', 'RightMainVerticalStack')),
    workspacePadding INTEGER DEFAULT 10, -- Workspace padding
    windowContainerBehaviour TEXT CHECK(window_container_behaviour IN ('Create', 'Append')), -- Behaviour for new windows
	minimumWindowHeight INTEGER,
	minimumWindowWidth INTEGER,

	-- foreign keys
	monitorID INTEGER NOT NULL, -- Foreign key reference to the Monitors table
    version_id INTEGER, -- Foreign key to KomorebiVersions to track the version
    FOREIGN KEY (monitor_id) REFERENCES Monitors(monitor_id),
    FOREIGN KEY (version_id) REFERENCES KomorebiVersions(version_id)
);

CREATE TABLE applications_borderOverflow (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	applicationID TEXT,
	kind TEXT, --validation
	matchingStrategy --validation
);
CREATE TABLE applications_floating (
	id INTEGER PRIMARY KEY AUTOINCREMENT
	applicationID TEXT,
	kind TEXT, --validation
	matchingStrategy --validation
);
