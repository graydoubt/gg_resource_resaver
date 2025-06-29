@tool
extends Node


func _ready() -> void:
	var parent = get_parent()
	if parent is RichTextLabel:
		parent.meta_clicked.connect(_on_meta_clicked)
		parent.meta_hover_started.connect(_on_hover_started)
		parent.meta_hover_ended.connect(_on_hover_ended)


func _on_meta_clicked(url: String) -> void:
	if url.begins_with("https://"):
		_open_url(url)
	elif url.begins_with("help:"):
		var topic = url.split(':', false, 1)[1]
		var script_editor: ScriptEditor = EditorInterface.get_script_editor()
		script_editor.goto_help(topic)
	elif url.begins_with("edit:"):
		var script_path = url.split(':', false, 1)[1]
		var script = load(script_path)
		EditorInterface.edit_script.call_deferred(script)
		EditorInterface.set_main_screen_editor("Script")
	elif url.begins_with("script_region:"):
		var region_info = url.split(":", false, 2)
		var region_name: String = region_info[1]
		var script_path: String = region_info[2]
		var script: GDScript = load(script_path)
		
		var line_number: int = _find_line_number_for_code("#region %s" % [region_name], script)
		if line_number:
			EditorInterface.edit_script.call_deferred(script, line_number)
			EditorInterface.set_main_screen_editor("Script")


func _on_hover_started(meta: String) -> void:
	pass


func _on_hover_ended(meta: String) -> void:
	pass


# Returns the line number (or 0 if not found).
func _find_line_number_for_code(code: String, script: GDScript) -> int:
	var lines = script.source_code.split("\n")

	var line_number: int = 1
	var found: bool = false
	for line in lines:
		if line.findn("%s" % [code]) > -1:
			found = true
			break
		line_number += 1

	if found:
		return line_number
	return 0


func _open_url(url: String) -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.open('%s', '%s', 'noopener=true').focus();" % [url, "_blank"])
	else:
		OS.shell_open(url)
