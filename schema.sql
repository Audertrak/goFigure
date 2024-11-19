-- top level profiles that "glue" subsequent tables
CREATE TABLE profiles (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL UNIQUE,
	description TEXT,
	monitorCount INTEGER,
	monitorIndex INTEGER,
	monitorName TEXT,
	createDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- bar specific configuration
CREATE TABLE komorebiBarConfigurations (
	id INTEGER PRIMRAY KEY AUTOINCREMENT,
	monitorIndex INTEGER NOT NULL,
	monitorName INTEGER NOT NULL,
	--resolution
	--field A
	--field B

	--foreign keys
	profileID INTEGER NOT NULL,
	komorebiConfigurationID INTEGER NOT NULL,
	komorebiVersion TEXT NOT NULL,
	FOREIGN KEY (profileID) REFERENCES profiles(id) ON DELETE CASCADE,
	FOREIGN KEY (komorebiConfigurationID) REFERENCES komorebiBarConfigurations(id),
	FOREIGN KEY (komorebiVersion) REFERENCES komorebiVersions(name)
);

-- application_specific_configuration.JSON
CREATE TABLE applicationSpecificConfigurations (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	applicationIdentifier TEXT CHECK(applicationIdentifier IN ('Exe', 'Class', 'Title', 'Path')),
	ruleType TEXT CHECK(ruleType IN ('floating', 'ignore', 'layered', 'manage', 'object_name_change', 'slow_application', 'transparency_ignore', 'tray_and_multi_window'))
	ruleID TEXT,
	ruleKind TEXT CHECK(ruleKind IN ('Exe', 'Class', 'Title', 'Path'))
	matchingStrategy TEXT CHECK(matchingStrategy IN ('Legacy', 'Equals', 'StartsWith', 'EndsWith', 'Contains', 'Regex', 'DoesNotEndWith', 'DoesNotStartWith', 'DoesNotEqual', 'DoesNotContain')),
	isArray BOOLEAN,

	-- foreign keys
	komorebiVersion TEXT NOT NULL,
	FOREIGN KEY (komorebiVersion) REFERENCES komorebiVersions(name),
	UNIQUE(applicationIdentifier, ruleType, ruleID)
);

-- versioning/revision control
CREATE TABLE komorebiVersions (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	releaseDate TEXT
);
