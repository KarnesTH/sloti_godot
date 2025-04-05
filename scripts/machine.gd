class_name Machine
extends Sprite2D

@onready var lever: AnimatedSprite2D = $Lever
@onready var slots = $Slots

@export_category("GameManager")
@export var gm: GameManager

func _ready() -> void:
	lever.connect("animation_finished", Callable(self, "_on_lever_animation_finished"))

func _process(_delta: float) -> void:
	if Input.is_action_pressed("pull"):
		lever.play("pull")

func _on_lever_animation_finished() -> void:
	var curr_money: int = int(gm.money.text) - int(gm.bet_value.text)
	if curr_money >= 0:
		gm.money.text = "$" + str(curr_money)
		slots._spin()
