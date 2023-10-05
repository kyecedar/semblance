@tool
class_name Logger
extends Node

enum TYPE {
	INFO,
	SUCCESS,
	WARNING,
	ERROR,
	FATAL,
}

# be wary of bbcode injection. dunno why or where that'd be a problem, but yeah.
static var LIGHT_TEXT_COLOR  : String = "#FFFFFF" ## BBCode text color.
static var RED_TEXT_COLOR    : String = "#FF5F5F" ## BBCode text color.
static var YELLOW_TEXT_COLOR : String = "#FFDE66" ## BBCode text color.
static var GREEN_TEXT_COLOR  : String = "#FFDE66" ## BBCode text color.
static var BLUE_TEXT_COLOR   : String = "#328FF3" ## BBCode text color.

static var logs : Array[String] = []
static var file : FileAccess
static var temp : String ## Used during etch string construction.

#region // 󱞁 ETCH.

## Push to log and file.
static func etch(text: String, system: String = "", status: TYPE = TYPE.INFO) -> void:
	
	print_rich()

static func get_status_string(status: TYPE) -> String:
	return TYPE.keys()[status]

#endregion 󱞁 ETCH.
