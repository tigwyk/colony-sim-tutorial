class_name InfoPanel
extends Control

var selectedObject: Object
var hoveredObject: Object
@export var nameLabel: Label

func _ready():
	# Make panel transparent
	modulate.a = 0.7
	visible = false

func setSelectedObject(object):
	if object.getType() in [Plant, Item, Building]:
		visible = true
		selectedObject = object
		updateDisplay(object)

func setHoveredObject(object):
	# Only show hover info if no object is selected
	if selectedObject != null:
		return
		
	if object == null:
		visible = false
		hoveredObject = null
		return
		
	if object.getType() in [Plant, Item, Building]:
		visible = true
		hoveredObject = object
		updateDisplay(object)

func updateDisplay(object):
	match object.getType():
		Plant:
			nameLabel.text = object.type.name
		Item:
			nameLabel.text = object.type.name
		Building:
			nameLabel.text = object.type.name

func _input(event: InputEvent) -> void:
	if event.is_action("escape") and event.is_pressed:
		visible = false
		selectedObject = null
		hoveredObject = null
