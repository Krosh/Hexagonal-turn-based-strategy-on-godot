var neighbours
var elements = []
var groundCode = 0
var moveCost = 1
var parent
var x
var y

var visibleCount = 0
var wasVisibled = false

var cube_x
var cube_y
var cube_z

var pathParent
var currentPathSize

func isPassable():
	return moveCost>0 && elements.size() == 0

func updateVisibleStatus(delta):
	if (delta > 0):
		wasVisibled = true
	visibleCount += delta
	parent.recalcFogForTile(self)

func registerObject(obj):
	elements.append(obj)
	# change visibility
	if (parent.useFog):
		var visibleRange = obj.visibleRange
		for x in range(max(obj.mapX-visibleRange,0),min(obj.mapX+visibleRange,parent.mapWidth)):
			for y in range(max(obj.mapY-visibleRange,0),min(obj.mapY+visibleRange,parent.mapHeight)):
				if (parent.getDistance(x,y,obj.mapX,obj.mapY) < visibleRange):
					parent.tiles[x][y].updateVisibleStatus(1)

func unregisterObject(obj):
	elements.erase(obj)
	if (parent.useFog):
		var visibleRange = obj.visibleRange
		for x in range(max(obj.mapX-visibleRange,0),min(obj.mapX+visibleRange,parent.mapWidth)):
			for y in range(max(obj.mapY-visibleRange,0),min(obj.mapY+visibleRange,parent.mapHeight)):
				if (parent.getDistance(x,y,obj.mapX,obj.mapY) < visibleRange):
					parent.tiles[x][y].updateVisibleStatus(-1)

func init():
	# calc move cost
	if (groundCode == 1):
		moveCost = -1
	if (groundCode == 4):
		moveCost = 3
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