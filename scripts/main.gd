extends Node2D

var selectedObject = null
var camera

func _ready():
	set_process(true)
	camera = get_node("camera")


func _process(delta):
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