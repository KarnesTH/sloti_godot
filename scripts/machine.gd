class_name Machine
extends Sprite2D

# Initiate variables on start
@onready var lever: AnimatedSprite2D = $Lever
@onready var slots = $Slots

# public variables
@export_category("GameManager")
@export var gm: GameManager

## Is called when the application is started.
func _ready() -> void:
	lever.connect("animation_finished", Callable(self, "_on_lever_animation_finished"))

## Updates on every framerate.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("pull"):
		gm.game_lbl.text = ""
		lever.play("pull")

## Signal to call the _spin() function if the animation from lever ready.
func _on_lever_animation_finished() -> void:
	var curr_money: int = int(gm.money.text) - int(gm.bet_value.text)
	if curr_money >= 0:
		gm.money.text = "$" + str(curr_money)
		slots._spin()
