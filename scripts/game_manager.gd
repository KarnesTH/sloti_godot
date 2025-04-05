class_name GameManager
extends Node

@export_category("UI Settings")
@export var game_lbl: Label
@export var money: Label
@export var bet_value: LineEdit
@export var inc_btn: Button
@export var dec_btn: Button
@export var cherry_lbl: Label
@export var bell_lbl: Label
@export var bar_lbl: Label

@export_category("Value Settings")
@export var start_money: int = 20000
@export var inc_dec_multiplier: int = 10
@export var min_bet_value: int = 50
@export var max_bet_value: int = 200
@export var jackpot: int = 1000
@export var cherry: int = 300
@export var bell: int = 200
@export var bar: int = 100

func _ready() -> void:
	game_lbl.text = ""
	money.text = "$" + str(start_money)
	bet_value.text = "50"
	cherry_lbl.text = "+ " + str(cherry)
	bell_lbl.text = "+ " + str(bell)
	bar_lbl.text = "+ " + str(bar)

func _process(_delta: float) -> void:
	if int(bet_value.text) == max_bet_value:
		inc_btn.disabled = true
	elif int(bet_value.text) == min_bet_value:
		dec_btn.disabled = true
	else:
		inc_btn.disabled = false
		dec_btn.disabled = false

func _increment(value: int) -> int:
	var result: int = 0
	result = value + inc_dec_multiplier
	return result

func _decrement(value: int) -> int:
	var result: int = 0
	result = value - inc_dec_multiplier
	return result


func _on_inc_btn_pressed() -> void:
	var value: int = int(bet_value.text)
	var result: int = _increment(value)
	bet_value.text = str(result)
	inc_btn.release_focus()


func _on_dec_btn_pressed() -> void:
	var value: int = int(bet_value.text)
	var result: int = _decrement(value)
	bet_value.text = str(result)
	dec_btn.release_focus()
