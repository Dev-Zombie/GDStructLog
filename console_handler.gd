extends LogHandler
class_name ConsoleHandler

func get_log_level_string(log_level: LoggingConfiguration.LogLevel) -> String:
    match log_level:
        LoggingConfiguration.LogLevel.DEBUG:
            return "DEBUG  "
        LoggingConfiguration.LogLevel.INFO:
            return "INFO   "
        LoggingConfiguration.LogLevel.WARNING:
            return "WARNING"
        LoggingConfiguration.LogLevel.ERROR:
            return "ERROR  "
    return "UNKNOWN LOG LEVEL"


func emit(date_time: String, log_level: LoggingConfiguration.LogLevel, message: String, context: Dictionary) -> void:
    var log_level_name: String = get_log_level_string(log_level)
    var context_string         = ""
    if context.size() > 0:
        context_string = " |"
    for key in context.keys():
        context_string += " %s=%s" % [key, str(context[key])]

    print("%s [%s]: %s %s" % [date_time, log_level_name, message, context_string])
