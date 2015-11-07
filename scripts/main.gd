extends Node2D

func _ready():
	set_process(true)

var leftMousePress = false
var leftMouseRelease = false
var rightMousePress = false
var rightMouseRelease = false

var selectedObject = null

func processInput():
	leftMouseRelease = false
	if (Input.is_mouse_button_pressed(1)):
		leftMousePress = true
	else:
		if (leftMousePress):
			leftMouseRelease = true
		leftMousePress = false
	rightMouseRelease = false
	if (Input.is_mouse_button_pressed(2)):
		rightMousePress = true
	else:
		if (rightMousePress):
			rightMouseRelease = true
		rightMousePress = false

func _process(delta):
	processInput()
	if (rightMouseRelease):
		selectedObject = null
		get_node("map").clearSelect()
	if (leftMouseRelease):
		var flag = true
		var cursorObject = null
		for item in get_node("map").get_node("items").get_children():
			if (item.get_item_rect().has_point(get_node("camera").globalPos-item.get_global_pos())):
				cursorObject = item
		if (selectedObject != null):
			if (cursorObject == null):
				selectedObject.findPath(get_node("camera").mapPos.x,get_node("camera").mapPos.y)
		else:
			if (cursorObject != null):
				selectedObject = cursorObject
				selectedObject.calculateReachZone()