class_name LoggingConfiguration
extends Resource

enum LogLevel { DEBUG, INFO, WARNING, ERROR }
@export var logging_enabled: bool = false
@export var log_level: LogLevel = LogLevel.INFO
@export var log_scene_root: bool = false


static func get_log_level_string(_log_level: LoggingConfiguration.LogLevel) -> String:
	match _log_level:
		LoggingConfiguration.LogLevel.DEBUG:
			return "DEBUG  "
		LoggingConfiguration.LogLevel.INFO:
			return "INFO   "
		LoggingConfiguration.LogLevel.WARNING:
			return "WARNING"
		LoggingConfiguration.LogLevel.ERROR:
			return "ERROR  "
	return "UNKNOWN LOG LEVEL"
