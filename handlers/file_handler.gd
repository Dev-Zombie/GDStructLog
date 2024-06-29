#extends LogHandler
#class_name FileHandler
#
#var file_path: String
#
#
#func _init(_file_path: String):
#    file_path = _file_path
#
#
#func emit(message: String, log_level: int) -> void:
#    var log_level_name = ["DEBUG", "INFO", "WARNING", "ERROR"][log_level]
#    var log_message    = "[%s]: %s\n" % [log_level_name, message]
#    var file           = File.new()
#    file.open(file_path, File.WRITE_APPEND)
#    file.store_string(log_message)
#    file.close()
