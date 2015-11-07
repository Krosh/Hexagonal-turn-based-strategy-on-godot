extends Camera2D

var mapPos = Vector2(0,0)
var cursorPos
var globalPos

func _ready():
	set_process(true)

func _process(delta):
	globalPos = get_global_mouse_pos()
	mapPos = get_parent().get_node("map").world_to_map(globalPos)
	cursorPos = get_local_mouse_pos()
	cursorPos = cursorPos+OS.get_window_size()*4/10
	if (cursorPos.x<50):
		set_pos(get_pos()-Vector2(0.1,0))
	if (cursorPos.y<50):
		set_pos(get_pos()-Vector2(0,0.1))
	if (cursorPos.x>590):
		set_pos(get_pos()+Vector2(0.1,0))
	if (cursorPos.y>430):
		set_pos(get_pos()+Vector2(0,0.1))