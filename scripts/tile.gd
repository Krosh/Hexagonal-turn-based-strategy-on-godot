var neighbours
var elements = []
var groundCode = 0
var moveCost = 1
var parent
var x
var y

var cube_x
var cube_y
var cube_z

var pathParent
var currentPathSize

func isPassable():
	return true
	return groundCode != 1 && elements.size() == 0

func registerObject(obj):
	elements.append(obj)

func unregisterObject(obj):
	elements.erase(obj)

func init():
	if (groundCode == 1):
		moveCost = 2
	# calc cube coords
	cube_x = x
	cube_z = y - (x - (x % 2)) / 2
	cube_y = -cube_x-cube_z
	# calc neighbourse
	neighbours = []
	if (y > 0):
		neighbours.append(parent.tiles[x][y-1])
	if (y<parent.mapHeight-1):
		neighbours.append(parent.tiles[x][y+1])
	if (x > 0):
		neighbours.append(parent.tiles[x-1][y])
		if (x % 2 == 1):
			if (y<parent.mapHeight-1):
				neighbours.append(parent.tiles[x-1][y+1])
		else:
			if (y>0):
				neighbours.append(parent.tiles[x-1][y-1])
	if (x < parent.mapWidth-1):
		neighbours.append(parent.tiles[x+1][y])
		if (x % 2 == 1):
			if (y<parent.mapHeight-1):
				neighbours.append(parent.tiles[x+1][y+1])
		else:
			if (y>0):
				neighbours.append(parent.tiles[x+1][y-1])