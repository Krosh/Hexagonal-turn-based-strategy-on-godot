extends Node2D

var selectedObject = null
var camera
var isUiChangeFogPressed = false
var isUiUpZoomPressed = false
var isUiDownZoomPressed = false
var mapZoom = 1.0

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
	if (Input.is_action_pressed("ui_up_zoom")):
		isUiUpZoomPressed = true
	else:
		if (isUiUpZoomPressed):
			mapZoom = max(0.1,mapZoom - 0.1)
			get_node("camera").set_zoom(Vector2(mapZoom,mapZoom))
			get_node("camera").set_scale(Vector2(mapZoom,mapZoom))
		isUiUpZoomPressed = false
	if (Input.is_action_pressed("ui_down_zoom")):
		isUiDownZoomPressed = true
	else:
		if (isUiDownZoomPressed):
			mapZoom = min(4,mapZoom + 0.1)
			get_node("camera").set_zoom(Vector2(mapZoom,mapZoom))
			get_node("camera").set_scale(Vector2(mapZoom,mapZoom))
		isUiDownZoomPressed = false
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