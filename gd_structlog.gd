extends Node
class_name Logger

var handlers: Array[LogHandler] = []
var logging_config: LoggingConfiguration
var scene_root: Node
var context_data: Dictionary    = {}


func _init(_logging_config: LoggingConfiguration, _scene_root: Node):
    logging_config = _logging_config
    scene_root = _scene_root
    handlers.append(ConsoleHandler.new())


func log_msg(message: String, log_level: LoggingConfiguration.LogLevel, data: Dictionary = {}):
    if logging_config.logging_enabled == false:
        return
    if log_level < logging_config.log_level:
        return
    if logging_config.log_scene_root:
        data["scene_root"] = scene_root.name
    for handler in handlers:
        handler.emit(get_current_datetime(), log_level, message, data)


func debug(message: String, data: Dictionary = {}):
    log_msg(message, LoggingConfiguration.LogLevel.DEBUG, data)


func info(message: String, data: Dictionary = {}):
    log_msg(message, LoggingConfiguration.LogLevel.INFO, data)


func warning(message: String, data: Dictionary = {}):
    log_msg(message, LoggingConfiguration.LogLevel.WARNING, data)


func error(message: String, data: Dictionary = {}):
    log_msg(message, LoggingConfiguration.LogLevel.ERROR, data)


func get_current_datetime() -> String:
    var datetime: Dictionary = Time.get_datetime_dict_from_system()
    return "%d-%02d-%02d %02d:%02d:%02d" % [datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute, datetime.second]


# method to find closest the logger in the scene tree
static func get_logger(node: Node) -> Logger:
    node = node.get_parent()
    while node:
        var props = node.get_property_list()
        for prop in props:
            if prop['class_name'] == &"Logger":
                if node[prop['name']] != null:
                    return node.get(prop["name"])
        node = node.get_parent()

    # If no logger is found, return a new logger enabled with debug
    print("No logger found in the scene tree. Creating a new one.")
    var logging_config: LoggingConfiguration = LoggingConfiguration.new()
    logging_config.log_level = LoggingConfiguration.LogLevel.DEBUG
    logging_config.logging_enabled = true
    return Logger.new(logging_config, node)
