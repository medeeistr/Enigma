extends Control

var solutie_corecta = [
	[1, 2, 3, 4],
	[3, 4, 1, 2],
	[2, 1, 4, 3],
	[4, 3, 2, 1]
]

var tabla_curenta = [
	[1, 0, 3, 0],
	[0, 4, 0, 2],
	[2, 0, 4, 0],
	[0, 3, 0, 1]
]

var tabla_initiala = [
	[1, 0, 3, 0],
	[0, 4, 0, 2],
	[2, 0, 4, 0],
	[0, 3, 0, 1]
]

var timp_ramas: float = 30.0 
var minigame_activ: bool = true

func _ready():
	# Cautam GridContainer oriunde s-ar afla in copiii acestei scene
	var grid = find_child("GridContainer", true, false)
	if not grid:
		print("Eroare: Nu am găsit GridContainer în scenă!")
		return

	var index = 1
	for rand in range(4):
		for col in range(4):
			var nume_nod = "Button" if index == 1 else "Button" + str(index)
			var buton = grid.get_node_or_null(nume_nod)
			
			if buton:
				buton.custom_minimum_size = Vector2(70, 70)
				buton.pressed.connect(_on_celula_pressed.bind(rand, col))
				
			index += 1
			
	actualizeaza_interfata()

func _process(delta: float):
	if not minigame_activ:
		return
		
	# Scadem timpul
	timp_ramas -= delta
	
	# Daca timpul s-a scurs
	if timp_ramas <= 0:
		minigame_activ = false
		print("Time's up! You lost a life.")

		Global.vieti -= 1
		
		inchide_minijoc(false)

func actualizeaza_interfata():
	var grid = find_child("GridContainer", true, false)
	if not grid:
		return

	var index = 1
	for rand in range(4):
		for col in range(4):
			var valoare = tabla_curenta[rand][col]
			var nume_nod = "Button" if index == 1 else "Button" + str(index)
			var buton = grid.get_node_or_null(nume_nod)
			
			if buton:
				if valoare != 0:
					buton.text = str(valoare)
				else:
					buton.text = ""
					
				if tabla_initiala[rand][col] != 0: #Nu permite modificarea celor default
					buton.disabled = true
				else:
					buton.disabled = false
					
			index += 1

func _on_celula_pressed(rand: int, col: int):
	if not minigame_activ:
		return
		
	if tabla_initiala[rand][col] == 0:
		tabla_curenta[rand][col] += 1
		if tabla_curenta[rand][col] > 4:
			tabla_curenta[rand][col] = 1 
		
		actualizeaza_interfata()
		verifica_castig()

func verifica_castig():
	if tabla_curenta == solutie_corecta:
		minigame_activ = false
		print("Great job! Sudoku solved successfully!")
		inchide_minijoc(true)

func inchide_minijoc(succes: bool):
	var jucator = get_tree().current_scene.get_node_or_null("Jucator")
	if jucator:
		jucator.poate_merge = true
		if succes:
			print("Prințul își continuă drumul.")
		else:
			print("Timpul a expirat, te-ai întors pe drum cu o viață lipsă.")
	
	# Închidem scena minijocului
	queue_free()
