extends Node
class_name LogProcessor

func process(_log_level: LoggingConfiguration.LogLevel, event_dict: Dictionary) -> Dictionary:
    return event_dict
