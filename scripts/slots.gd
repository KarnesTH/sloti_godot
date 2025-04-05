class_name Slots
extends Sprite2D

@export_category("Sprites & Tiles")
@export var slot_tiles: Array[Sprite2D] = []
@export var tile_sprites: Array[CompressedTexture2D] = []

@export_category("Spin settings")
@export var spins_per_tile: int = 10
@export var delay: float = 0.2
@export var spin_speed: float = 0.05

@export_category("GameManager")
@export var gm: GameManager


func _ready() -> void:
	for slot_tile in slot_tiles:
		var rnd_idx: int = randi_range(0, tile_sprites.size() - 1)
		
		slot_tile.texture = tile_sprites[rnd_idx]

func _spin() -> void:
	for idx in slot_tiles.size():
		_spin_tile(idx)
		await get_tree().create_timer(delay).timeout

func _spin_tile(idx: int) -> void:
	var tile = slot_tiles[idx]
	
	call_deferred("_do_spin_animation", tile)

func _do_spin_animation(tile: Sprite2D) -> void:
	for idx in spins_per_tile:
		var rnd_idx: int = randi_range(0, tile_sprites.size() - 1)
		tile.texture = tile_sprites[rnd_idx]
		await get_tree().create_timer(spin_speed).timeout
	
	var final_idx: int = randi_range(0, tile_sprites.size() - 1)
	tile.texture = tile_sprites[final_idx]
	

func _check_is_match() -> bool:
	var tile_1: Texture2D = slot_tiles[0].texture
	var tile_2: Texture2D = slot_tiles[1].texture
	var tile_3: Texture2D = slot_tiles[2].texture
	
	if tile_1 == tile_2 and tile_2 == tile_3:
		return true
	
	return false
