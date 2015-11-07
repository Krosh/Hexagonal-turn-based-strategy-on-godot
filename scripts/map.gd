extends TileMap

export var mapWidth = 10
export var mapHeight = 10


var colorMap
const COLOR_YELLOW = 1
const COLOR_RED = 2


var tiles
var TileClass = preload("res://scripts/tile.gd")

func createTile(x,y,groundCode):
	tiles[x].append(TileClass.new())
	tiles[x][y].groundCode = groundCode
	tiles[x][y].parent = self
	tiles[x][y].x = x
	tiles[x][y].y = y

func createMap():
	tiles = []
	for x in range(mapWidth):
		tiles.append([])
		for y in range(mapHeight):
			var groundCode = randi() % 3
			createTile(x,y,groundCode)
			set_cell(x,y,groundCode)
	for x in range(mapWidth):
		for y in range(mapHeight):
			tiles[x][y].calcNeigbours()

func registerObject(obj):
	tiles[obj.mapX][obj.mapY].registerObject(obj)

func unregisterObject(obj):
	tiles[obj.mapX][obj.mapY].unregisterObject(obj)

func clearSelect():
	for x in range(mapWidth):
		for y in range(mapHeight):
			colorMap.set_cell(x,y,0)
			tiles[x][y].parent = null
			tiles[x][y].currentPathSize = 999


func calculateReachZone(startX, startY, searchRange, flight):
	for x in range(mapWidth):
		for y in range(mapHeight):
			colorMap.set_cell(x,y,0)
			tiles[x][y].parent = null
			tiles[x][y].currentPathSize = 999
	tiles[startX][startY].currentPathSize = 0
	var searchedTiles = [tiles[startX][startY]]
	colorMap.set_cell(startX,startY,COLOR_YELLOW)
	var flag = true
	while (flag && searchedTiles.size()>0):
		var i = 0
		var curTile = searchedTiles[i]
		if (curTile.currentPathSize < searchRange):
			for item in curTile.neighbours:
				if ((flight || item.isPassable()) && item.currentPathSize > curTile.currentPathSize + 1):
					item.currentPathSize = curTile.currentPathSize + 1
					item.pathParent = curTile
					colorMap.set_cell(item.x,item.y,COLOR_YELLOW)
					searchedTiles.append(item)
		searchedTiles.remove(i)

func findPath(startX, startY, endX, endY, flight, needRecalcPath = false):
	if (needRecalcPath):
		for x in range(mapWidth):
			for y in range(mapHeight):
				tiles[x][y].parent = null
				tiles[x][y].currentPathSize = 999
		tiles[startX][startY].currentPathSize = 0
		var searchedTiles = [tiles[startX][startY]]
		var flag = true
		while (flag && searchedTiles.size()>0):
			var i = 0
			var curTile = searchedTiles[i]
			for item in curTile.neighbours:
				if ((flight || item.isPassable()) && item.currentPathSize > curTile.currentPathSize + 1):
					item.currentPathSize = curTile.currentPathSize + 1
					item.pathParent = curTile
					searchedTiles.append(item)
				if (item.x == endX && item.y == endY):
					flag = false
			searchedTiles.remove(i)
	if (tiles[endX][endY].currentPathSize<999):
		var path = []
		var x = endX
		var y = endY
		while (x != startX || y != startY):
			path.append(Vector2(x,y))
			var newX = tiles[x][y].pathParent.x
			var newY = tiles[x][y].pathParent.y
			x = newX
			y = newY
		return path
	return []

func _ready():
	createMap()
	colorMap = get_node("colormap")
	set_process(true)
