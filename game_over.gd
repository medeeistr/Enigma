extends Control #Mostenim proprietatile nodului principal

@onready var start_button = $VBoxContainer/Button

func _ready() -> void:
	if not start_button.pressed.is_connected(_on_start_button_pressed):
		start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	Global.vieti = 3 #Resetam vietile
	get_tree().change_scene_to_file("res://Nivel1.tscn")
