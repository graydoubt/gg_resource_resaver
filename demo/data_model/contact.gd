class_name MyContact extends Resource


@export var first_name: String

@export var last_name: String

@export var company: String

@export var title: String

@export var phone_number: String

@export_group("Addresses")

@export var business_address: MyAddress

@export var home_address: MyAddress
