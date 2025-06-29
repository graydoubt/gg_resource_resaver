@tool
extends Window

@export_group("Internal")


@export var progress_bar: ProgressBar

@export var status_label: Label

@export var resave_resources_checkbox: CheckBox

@export var resave_scenes_checkbox: CheckBox

@export var show_progress_checkbox: CheckBox

@export var run_button: Button

@export var close_button: Button

@export var info_button: Button


func _ready() -> void:
	close_requested.connect(_on_close_requested)
	
	run_button.pressed.connect(_run)
	close_button.pressed.connect(_on_close_requested)


func close() -> void:
	queue_free()


func _run() -> void:
	var filenames : Array[String] = []
	
	_set_status("Discovering files...")
	progress_bar.visible = true
	await get_tree().process_frame
	
	var file_types: Array[String] = []
	if resave_resources_checkbox.button_pressed:
		file_types.append("tres")
	if resave_scenes_checkbox.button_pressed:
		file_types.append("tscn")
	filenames.append_array(_build_file_list("res://", file_types, -1))
	
	var total: int = filenames.size()
	var current: int = 0
	
	_set_status("Updating files...")
	await get_tree().process_frame
	
	for filename in filenames:
		current += 1
		if show_progress_checkbox.button_pressed:
			_set_status("Updating %s ..." % [filename])
			await get_tree().process_frame
		var res: Resource = ResourceLoader.load(filename)
		ResourceSaver.save(res, res.resource_path)
		progress_bar.value = float(current) / float(total) * 100.0
	
	_set_status("Done.")


func _set_status(text: String) -> void:
	status_label.text = text

static func _build_file_list(
	path: String, 
	suffixes: Array[String], 
	recursion_depth: int
) -> Array[String]:
	var dir = DirAccess.open(path)
	if not dir:
		push_error("An error occurred when trying to access path: %s" % [path])
		return []

	var files: Array[String]
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir() and recursion_depth:
			var sub_dir: String = "%s/%s" % [path, file_name]
			files.append_array(_build_file_list(sub_dir, suffixes, recursion_depth - 1))
		elif suffixes.has(file_name.get_extension()):
			var full_path = "%s/%s" % [path, file_name]
			files.append(full_path)
		file_name = dir.get_next()

	return files


func _on_close_requested() -> void:
	close()
