extends Camera2D

var mapPos = Vector2(0,0)
var cursorPos
var globalPos
const SPEED = 100.0

var leftMousePress = false
var leftMouseRelease = false
var rightMousePress = false
var rightMouseRelease = false


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


func _ready():
	set_process(true)

func _process(delta):
	processInput()
	globalPos = get_global_mouse_pos()
	mapPos = get_parent().get_node("map").world_to_map(globalPos)
	cursorPos = get_local_mouse_pos()
	cursorPos = cursorPos+OS.get_window_size()*4/10
	if (cursorPos.x<50):
		set_pos(get_pos()-Vector2(SPEED*delta,0))
	if (cursorPos.y<50):
		set_pos(get_pos()-Vector2(0,SPEED*delta))
	if (cursorPos.x>590):
		set_pos(get_pos()+Vector2(SPEED*delta,0))
	if (cursorPos.y>430):
		set_pos(get_pos()+Vector2(0,SPEED*delta))