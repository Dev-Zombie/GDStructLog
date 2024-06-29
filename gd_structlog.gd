extends Node
class_name GdStructlog

var logging_config: LoggingConfiguration
var processors: Array[LogProcessor] = []
var context_data: Dictionary        = {}
var scene_root: Node


func _init(_logging_config: LoggingConfiguration, _scene_root: Node):
    logging_config = _logging_config
    scene_root = _scene_root
    processors.append(ConsoleRenderer.new())


func log_msg(event: String, log_level: LoggingConfiguration.LogLevel, data: Dictionary = {}):
    if logging_config.logging_enabled == false:
        return
    if log_level < logging_config.log_level:
        return
    if logging_config.log_scene_root:
        data["scene_root"] = scene_root.name

    data['event'] = event
    data.merge(context_data)
    for process in processors:
        process.process(log_level, data)


func debug(event: String, data: Dictionary = {}):
    log_msg(event, LoggingConfiguration.LogLevel.DEBUG, data)


func info(event: String, data: Dictionary = {}):
    log_msg(event, LoggingConfiguration.LogLevel.INFO, data)


func warning(event: String, data: Dictionary = {}):
    log_msg(event, LoggingConfiguration.LogLevel.WARNING, data)


func error(event: String, data: Dictionary = {}):
    log_msg(event, LoggingConfiguration.LogLevel.ERROR, data)


func get_current_datetime() -> String:
    var datetime: Dictionary = Time.get_datetime_dict_from_system()
    return "%d-%02d-%02d %02d:%02d:%02d" % [datetime.year, datetime.month, datetime.day, datetime.hour, datetime.minute, datetime.second]


# method to find closest the logger in the scene tree
static func get_logger(node: Node) -> GdStructlog:
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
    return GdStructlog.new(logging_config, node)
