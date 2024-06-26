extends Node2D
@onready var tile_map = $TileMap
@onready var player = $Player

@export var noise_height_text:NoiseTexture2D
@export var noise_tree_text:NoiseTexture2D
var tree_noise:Noise
var noise:Noise
var height=100
var width=100
var noise_val
var land_source_id=0
var water_source_id=11
var trees_source_id=1
var water_atlas=Vector2i(0,1)
var land_atlas=Vector2i(3,1)

var water_layer=0
var ground_layer_1=1
var ground_layer_2=2
var cliff_layer=3
var environment_layer=4

var grass_atlas_arr=[Vector2i(1,0),Vector2i(2,0),Vector2i(3,0),Vector2i(4,0),Vector2i(5,0)]
var trees1=[Vector2i(0,0),Vector2i(2,0)]
var trees2=[Vector2i(4,0),Vector2i(6,0)]
#var green_trees=[Vector2i(12,2),Vector2i(15,2)]


var cliff_tiles_arr=[]
var terrain_cliff_int=4
var grass_tiles_arr=[]
var terrain_grass_int=1
var land_tiles_arr=[]
var terrain_land_int=0
var environemnt_tiles_arr=[]
var environment_terrain_int=2
var dirt_terrain_arr=[]
var dirt_terrain_int=3

#
#var val;
#var max=[]

func _ready():
	noise=noise_height_text.noise
	tree_noise=noise_tree_text.noise
	tree_noise.seed=randi()
	#noise.seed=randi()
	noise.seed=11165351
	print(noise.seed)
	generate_world()
	#11165351
	
func generate_world():
	for x in range(-height/2,height/2):
		for y in range(-width/2,width/2):
			noise_val=noise.get_noise_2d(x,y)
			var tree_noise_val=tree_noise.get_noise_2d(x,y)
			
			
			if noise_val>0.0:
			
				if noise_val >0.05 and noise_val<0.17 and tree_noise_val>0.85:
					tile_map.set_cell(environment_layer,Vector2i(x,y),1,trees1.pick_random())
					#environemnt_tiles_arr.append(Vector2i(x,y))
				
				#if noise_val>0.2 and noise_val<0.3:
					#tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,Vector2i(2,0))
				#else:
				land_tiles_arr.append(Vector2i(x,y))
				#val=noise.get_noise_2d(x,y)
				#max.append(val)

			if noise_val>0.2:
				grass_tiles_arr.append(Vector2i(x,y))
				
				if noise_val>0.25:
					if noise_val>0.35 and tree_noise_val>0.82:
						tile_map.set_cell(environment_layer,Vector2i(x,y),1,trees2.pick_random())
					tile_map.set_cell(ground_layer_2,Vector2i(x,y),11,grass_atlas_arr.pick_random())
					
			if noise_val>0.45:
				cliff_tiles_arr.append(Vector2i(x,y))
			
			if noise_val<0 or noise_val>0.57363891601563:
				tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,water_atlas)
			
			#if noise_val>-0.03 and  noise_val<-0.02:
				#tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,Vector2i(3,0))
				##dirt_terrain_arr.append(Vector2i(x,y))
			
	tile_map.set_cells_terrain_connect(ground_layer_1,land_tiles_arr,terrain_land_int,0)
	tile_map.set_cells_terrain_connect(ground_layer_1,grass_tiles_arr,terrain_grass_int,0)
	tile_map.set_cells_terrain_connect(cliff_layer,cliff_tiles_arr,terrain_cliff_int,0)
	#tile_map.set_cells_terrain_connect(water_layer,dirt_terrain_arr,dirt_terrain_int,0)
	#tile_map.set_cells_terrain_connect(environment_layer,environemnt_tiles_arr,environment_terrain_int,0)
	#print("max",max.max())
	#print(max.min())
	for x in range(height/2,6*height/5):
		for y in range(-(6*width/5),(6*width/5)):
			var a=noise.get_noise_2d(x,y)
			if a:
				tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,water_atlas)
	for x in range(-(6*height/5),-(height/2)):
		for y in range(-(6*width/5),(6*width/5)):
			var a=noise.get_noise_2d(x,y)
			if a:
				tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,water_atlas)
				
				
				#South one below
				
	for y in range(width/2,(6*width/5)):
		for x in range(-height/2,height/2):
			var a=noise.get_noise_2d(x,y)
			if a:
				tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,water_atlas)
				#
	for y in range(-(6*width/5),-width/2):
		for x in range(-height/2,height/2):
			var a=noise.get_noise_2d(x,y)
			if a:
				tile_map.set_cell(water_layer,Vector2i(x,y),water_source_id,water_atlas)





