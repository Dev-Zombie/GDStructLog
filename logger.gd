extends Node
class_name Logger

var handlers: Array[LogHandler] = []
var logging_config: LoggingConfiguration


func _init(_logging_config: LoggingConfiguration):
	logging_config = _logging_config
	handlers.append(ConsoleHandler.new())


func log_msg(message: String, log_level: int, context: Dictionary = {}):
	if logging_config.logging_enabled == false:
		return
	if log_level >= logging_config.log_level:
		for handler in handlers:
			handler.emit(get_current_datetime(), log_level, message, context)


func debug(message: String, context: Dictionary = {}):
	log_msg(message, LoggingConfiguration.LogLevel.DEBUG, context)


func info(message: String, context: Dictionary = {}):
	log_msg(message, LoggingConfiguration.LogLevel.INFO, context)


func warning(message: String, context: Dictionary = {}):
	log_msg(message, LoggingConfiguration.LogLevel.WARNING, context)


func error(message: String, context: Dictionary = {}):
	log_msg(message, LoggingConfiguration.LogLevel.ERROR, context)


func get_current_datetime() -> String:
	var datetime: Dictionary = Time.get_datetime_dict_from_system()
	return "%d-%02d-%02d %02d:%02d:%02d" % [datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute, datetime.second]
