var neighbours
var elements = []
var groundCode = 0
var parent
var x
var y

var pathParent
var currentPathSize

func isPassable():
	return groundCode != 1 && elements.size() == 0

func registerObject(obj):
	elements.append(obj)

func unregisterObject(obj):
	elements.erase(obj)

func calcNeigbours():
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