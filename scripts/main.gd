extends Node2D

var selectedObject = null
var camera
var isUiChangeFogPressed = false

func _ready():
	set_process(true)
	camera = get_node("camera")
	for item in get_node("map/items").get_children():
		get_node("map").registerObject(item)


func _process(delta):
	if (Input.is_action_pressed("ui_changeFog")):
		isUiChangeFogPressed = true
	else:
		if (isUiChangeFogPressed):
			get_node("map").useFog = !get_node("map").useFog
			get_node("map").initFogMap()
		isUiChangeFogPressed = false
	if (camera.rightMouseRelease):
		selectedObject = null
		get_node("map").clearSelect()
	if (camera.leftMouseRelease):
		var flag = true
		var cursorObject = null
		for item in get_node("map").get_node("items").get_children():
			if (item.get_item_rect().has_point(camera.globalPos-item.get_global_pos())):
				cursorObject = item
		if (selectedObject != null):
			if (cursorObject == null):
				if (selectedObject.isMoved()):
					selectedObject.stopMove()
				else:
					selectedObject.findPath(camera.mapPos.x,camera.mapPos.y)
			else:
				selectedObject.attack(camera.mapPos.x,camera.mapPos.y)
		else:
			if (cursorObject != null):
				selectedObject = cursorObject
				selectedObject.calculateReachZone()