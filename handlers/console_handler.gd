extends LogHandler
class_name ConsoleHandler

func emit(date_time: String, log_level: LoggingConfiguration.LogLevel, message: String, data: Dictionary) -> void:
    var log_level_name: String = LoggingConfiguration.get_log_level_string(log_level)
    var context_string         = ""
    for key in data.keys():
        context_string += " %s=%s" % [key, str(data[key])]
    if data == {}:
        print("%s [%s]: %s" % [date_time, log_level_name, message])
    else:
        print("%s [%s]: %s    | %s " % [date_time, log_level_name, message, context_string])
