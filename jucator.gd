extends CharacterBody2D

const SPEED = 300.0
var poate_merge = true #O variabila care opreste printul cand intra in provocare

func _physics_process(_delta):
	#Daca nu are voie sa mearga, oprim miscarea
	if not poate_merge:
		velocity.x = 0
		move_and_slide()
		return

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_punct_provocare_1_body_entered(body):
	if body == self:
		print("Se deschide minijocul 1!")
		poate_merge = false 
		
		var scena_minijoc = load("res://Minijoc1.tscn").instantiate()
		get_tree().root.add_child(scena_minijoc)

func _on_punct_provocare_2_body_entered(body):
	if body == self:
		print("Se deschide Sudoku!")
		poate_merge = false 
		
		var minijoc = load("res://MinijocSudoku.tscn").instantiate()
		get_tree().current_scene.add_child(minijoc)

func _on_punct_provocare_3_body_entered(body):
	if body == self:
		print("Se deschide a treia provocare!")
		poate_merge = false 
		
		var minijoc = load("res://MinijocRiddle.tscn").instantiate()
		get_tree().current_scene.add_child(minijoc)


func _on_a_922529f_6d_36_afcde_3e_5f_668c_3d_754_body_entered(body: Node2D) -> void:
	if body.name == "Jucator":
		if Global.vieti > 0:
			get_tree().call_deferred("change_scene_to_file", "res://finish.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://game_over.tscn")
