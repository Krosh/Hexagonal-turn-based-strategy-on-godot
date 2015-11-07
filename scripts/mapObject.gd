extends Sprite

export var mapX = 0
export var mapY = 0

var steps = 5

var maxHp = 10
var hp = maxHp

var attack = 5
var attackRange = 1

var path = []
var moveAnimTime = 0.0
var frameMoveAnimTime = 0.3

func get_map():
	return get_parent().get_parent()

func _ready():
	set_process(true)

func findPath(targetX, targetY):
	moveAnimTime = 0
	path = get_map().findPath(mapX,mapY,targetX,targetY,false)

func calculateReachZone():
	get_map().calculateReachZone(mapX,mapY,steps,false)


func attack(targetX, targetY):
	print("Attacked!!!")
	var attackPath = get_map().findPath(mapX,mapY,targetX,targetY,true)
	if (attackPath.size()<=attackRange):
		print("Touched!!!")

func _process(delta):
	if (path.size()>0):
		var deltaPos = get_map().map_to_world(Vector2(path[path.size()-1].x,path[path.size()-1].y)) - get_map().map_to_world(Vector2(mapX,mapY))
		set_pos(get_map().map_to_world(Vector2(mapX,mapY)) + moveAnimTime / frameMoveAnimTime * deltaPos)
		moveAnimTime += delta
		if (moveAnimTime > frameMoveAnimTime):
			get_map().unregisterObject(self)
			moveAnimTime = 0
			mapX = path[path.size()-1].x
			mapY = path[path.size()-1].y
			path.remove(path.size()-1)
			get_map().registerObject(self)
			if (path.size() == 0 && get_map().get_parent().selectedObject == self):
				calculateReachZone()
	else:
		set_pos(get_map().map_to_world(Vector2(mapX,mapY)))

