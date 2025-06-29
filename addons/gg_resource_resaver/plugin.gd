@tool
extends EditorPlugin


const TOOL_MENU_NAME = "Re-save Resources..."

const TOOL_SCENE = "res://addons/gg_resource_resaver/resource_resaver_tool.tscn"


func _enter_tree() -> void:
	add_tool_menu_item(TOOL_MENU_NAME, _show_tool)


func _exit_tree() -> void:
	remove_tool_menu_item(TOOL_MENU_NAME)


func _show_tool() -> void:
	var tool: Window = load(TOOL_SCENE).instantiate()
	EditorInterface.get_base_control().add_child(tool)
	tool.popup_centered()
