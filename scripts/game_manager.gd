class_name GameManager
extends Node

# public variables
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

# private variables
var final_symbols: String

## Is called when the application is started.
func _ready() -> void:
	game_lbl.text = ""
	money.text = "$" + str(start_money)
	bet_value.text = "50"
	cherry_lbl.text = "+ " + str(cherry)
	bell_lbl.text = "+ " + str(bell)
	bar_lbl.text = "+ " + str(bar)

## Updates on every framerate.
func _process(_delta: float) -> void:
	if int(bet_value.text) == max_bet_value:
		inc_btn.disabled = true
	elif int(bet_value.text) == min_bet_value:
		dec_btn.disabled = true
	else:
		inc_btn.disabled = false
		dec_btn.disabled = false

## Handles the result of the slot spin.
##
## @param result: String - given string to check
func _handle_match(result: String) -> void:
	match result:
		"jackpot":
			_calculate_win()
		"partial_match":
			pass
		"no_match":
			pass

## Updates the label to show winnings based on the current bet and symbol bonus.
func _calculate_win() -> void:
	var bonus: int = 0
	match final_symbols:
		"slot-symbol1":
			bonus = jackpot
		"slot-symbol2":
			bonus = cherry
		"slot-symbol3":
			bonus = bell
		"slot-symbol4":
			bonus = bar
	var win: int = int(bet_value.text) + bonus
	money.text = "$" + str(int(money.text) + win) 
	game_lbl.text = "YOU WIN + $" + str(win) 

## Increment the bet value.
##
## @param value: int - The current bet value
func _increment(value: int) -> int:
	var result: int = 0
	result = value + inc_dec_multiplier
	return result

## Decrement the bet value.
##
## @param value: int - The current bet value
func _decrement(value: int) -> int:
	var result: int = 0
	result = value - inc_dec_multiplier
	return result

## Updates bet value on Button pressed() Signal to
## increment the current bet value.
func _on_inc_btn_pressed() -> void:
	var value: int = int(bet_value.text)
	var result: int = _increment(value)
	bet_value.text = str(result)
	inc_btn.release_focus()

## Updates bet value on Button pressed() Signal to
## decrement the current bet value.
func _on_dec_btn_pressed() -> void:
	var value: int = int(bet_value.text)
	var result: int = _decrement(value)
	bet_value.text = str(result)
	dec_btn.release_focus()
