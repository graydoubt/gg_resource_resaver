class_name EquippableItemType extends MyItemType


@export var equipment_scene: PackedScene

@export var default_upgrades: Dictionary


func _factory_class() -> MyItemData:
	return EquippableItemData.new()
