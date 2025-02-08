extends LogProcessor
class_name ConsoleRenderer

func process(log_level: LoggingConfiguration.LogLevel, event_dict: Dictionary) -> Dictionary:
	var log_level_name: String = LoggingConfiguration.get_log_level_string(log_level)
	var data: Dictionary       = event_dict # make a copy of the event_dict to avoid modifying the original
	var context_string: String = ""
	var prefix: String         = ""
	var postfix: String        = ""

	if data.has('date_time'):
		var date_time: String = data['date_time']
		data.erase('date_time')
		prefix = "%s " % date_time

	prefix = prefix + "[" + log_level_name + "]"

	if data.has('root_node'):
		prefix +=  "[" + data['root_node'] + "]"
		data.erase('root_node')

	var log_message: String = data['event']
	data.erase('event')
	prefix += ": " + log_message

	for key in data.keys():
		context_string += " %s = %s" % [key, str(data[key])]

	if event_dict == {}:
		print(prefix)
	else:
		print("%s    | %s " % [prefix, context_string])

	return event_dict
