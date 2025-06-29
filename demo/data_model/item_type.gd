class_name MyItemType extends Resource


@export var name: String

@export var icon: Texture2D

@export_multiline var description: String

@export var stats: Dictionary = {}


func create_item(properties: Dictionary = {}) -> MyItemData:
	if not properties.has("quantity"):
		properties["quantity"] = 1
	var item: MyItemData = _factory_class()
	item.type = self
	for property: String in properties:
		if property in item:
			item[property] = properties[property]
	return item


func _factory_class() -> MyItemData:
	return MyItemData.new()
