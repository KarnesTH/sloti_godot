extends Sprite2D

@onready var lever: AnimatedSprite2D = $Lever
@onready var slots = $Slots

func _ready() -> void:
	lever.connect("animation_finished", Callable(self, "_on_lever_animation_finished"))

func _process(_delta: float) -> void:
	if Input.is_action_pressed("pull"):
		lever.play("pull")

func _on_lever_animation_finished() -> void:
	slots._spin()
