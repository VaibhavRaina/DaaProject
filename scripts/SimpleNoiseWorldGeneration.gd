extends Node2D

@export var width = 500
@export var height = 500
@onready var tile_map = $TileMap
var temperature = {}
var biome = {}
var altitude = {}
var moisture = {}
var openSimplexNoise = FastNoiseLite.new()

func _ready():
	openSimplexNoise.noise_type = FastNoiseLite.TYPE_PERLIN
	temperature = generate_map(300, 5)
	moisture = generate_map(300, 5)
	altitude = generate_map(150, 5)
	set_tiles()

func generate_map(period, octaves):
	openSimplexNoise.noise_type = FastNoiseLite.TYPE_PERLIN
	openSimplexNoise.seed = randi()
	openSimplexNoise.frequency = period
	openSimplexNoise.fractal_octaves = octaves
	var grid_name = {}
	for x in range(width):
		for y in range(height):
			var rand = 2 * abs(openSimplexNoise.get_noise_2d(x, y))
			grid_name[Vector2(x, y)] = rand
	return grid_name

func set_tiles():
	for x in range(width):
		for y in range(height):
			var pos = Vector2(x, y)
			var alt = altitude[pos]
			var temp = temperature[pos]
			var moist = moisture[pos]
			
			# Example logic to set different tiles based on altitude, temperature, and moisture
			if alt < 0.2:
				tile_map.set_cell(x, y, 0)  # Example tile ID for water
			elif alt < 0.4:
				tile_map.set_cell(x, y, 1)  # Example tile ID for sand
			elif alt < 0.6:
				tile_map.set_cell(x, y, 2)  # Example tile ID for grass
			elif alt < 0.8:
				tile_map.set_cell(x, y, 3)  # Example tile ID for forest
			else:
				tile_map.set_cell(x, y, 4)  # Example tile ID for mountain
