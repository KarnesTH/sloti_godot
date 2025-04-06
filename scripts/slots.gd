class_name Slots
extends Sprite2D

# public variables
@export_category("Sprites & Tiles")
@export var slot_tiles: Array[Sprite2D] = []
@export var tile_sprites: Array[CompressedTexture2D] = []

@export_category("Spin settings")
@export var spins_per_tile: int = 10
@export var delay: float = 0.2
@export var spin_speed: float = 0.05

@export_category("GameManager")
@export var gm: GameManager

# private variables
var finished_spins: int = 0

## Is called when the application is started.
func _ready() -> void:
	for slot_tile in slot_tiles:
		var rnd_idx: int = randi_range(0, tile_sprites.size() - 1)
		
		slot_tile.texture = tile_sprites[rnd_idx]

## Spins all slot tiles with a delay.
func _spin() -> void:
	finished_spins = 0
	for idx in slot_tiles.size():
		_spin_tile(idx)
		await get_tree().create_timer(delay).timeout

## Spins a tile by a given index.
##
## @params idx: int - The index for a tile in the slot_tiles array
func _spin_tile(idx: int) -> void:
	var tile = slot_tiles[idx]
	
	call_deferred("_do_spin_animation", tile)

## Animate the spin for a given tile.
##
## @param tile: Sprite2D - The tile to animate
func _do_spin_animation(tile: Sprite2D) -> void:
	for idx in spins_per_tile:
		var rnd_idx: int = randi_range(0, tile_sprites.size() - 1)
		tile.texture = tile_sprites[rnd_idx]
		await get_tree().create_timer(spin_speed).timeout
	
	var final_idx: int = randi_range(0, tile_sprites.size() - 1)
	tile.texture = tile_sprites[final_idx]
	
	finished_spins += 1
	if finished_spins == slot_tiles.size():
		var result = _check_is_match()
		gm._handle_match(result)

## Returns the index of a tile.
##
## @param texture: CompressedTexture2D - The texture to find the index
func _get_tile_index(texture: CompressedTexture2D) -> int:
	return tile_sprites.find(texture)

## Returns the name of the file name.
##
## @param tile: Sprite2D - The sprite to get the file name
func _get_tile_name(tile: Sprite2D) -> String:
	var path: String = tile.texture.resource_path
	var file_name: String = path.get_file().get_slice(".png", 0)
	return file_name

## Check the slots for matches.
func _check_is_match() -> String:
	var idxs: Array[int] = []
	for tile in slot_tiles:
		idxs.append(_get_tile_index(tile.texture))
		gm.final_symbols = _get_tile_name(tile)
	
	if idxs[0] == idxs[1] and idxs[1] == idxs[2]:
		return "jackpot"
	elif idxs[0] == idxs[1] or idxs[0] == idxs[2] or idxs[1] == idxs[2]:
		return "partial_match"
	else:
		return "no_match"
