extends Panel

var caseta_periculoasa = 0

func _ready():
	randomize()
	caseta_periculoasa = randi() % 3 + 1
	print("Minijocul a pornit. Caseta periculoasa este: ", caseta_periculoasa)

func _verifica_alegerea(numar_buton: int):
	if numar_buton == caseta_periculoasa:
		print("Ai pierdut o viață!")
		Global.vieti -= 1
		deblocheaza_jucatorul()
	else:
		print("Ai trecut minijocul cu succes!")
		deblocheaza_jucatorul()

func deblocheaza_jucatorul():
	var jucator = get_tree().current_scene.get_node_or_null("Jucator")
	
	if jucator:
		jucator.poate_merge = true
		print("Jucătorul a fost deblocat!")
	else:
		print("Eroare: Nu am găsit nodul Jucator!")
	
	# Inchidem fereastra minijocului
	queue_free()

func _on_button_1_pressed() -> void:
	_verifica_alegerea(1)


func _on_button_2_pressed() -> void:
	_verifica_alegerea(2)


func _on_button_3_pressed() -> void:
	_verifica_alegerea(3)
