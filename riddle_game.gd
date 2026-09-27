extends Control

var riddles = [
	{
		"question": "To finish the game, you must answer: \n			I speak without a mouth and hear without ears. \n			I have no body, but I come alive with wind. What am I?",
		"answer": "echo"
	},
	{
		"question": "What has to be broken before you can use it?",
		"answer": "egg"
	}
]

var current_riddle_index = 0

#Referinte catre noduri
@onready var question_label = $VBoxContainer/QuestionLabel
@onready var answer_input = $VBoxContainer/AnswerInput
@onready var submit_button = $VBoxContainer/SubmitButton
@onready var feedback_label = $VBoxContainer/FeedbackLabel

func _ready() -> void:
	#Conectam semnalul butonului la o functie
	submit_button.pressed.connect(_on_submit_pressed)
	#Incarcam prima ghicitoare
	load_riddle()

func load_riddle() -> void:
	if current_riddle_index < riddles.size():
		var current = riddles[current_riddle_index]
		question_label.text = current["question"]
		answer_input.text = ""
		feedback_label.text = ""
		#Ne asiguram ca inputul si butonul sunt active
		answer_input.editable = true
		submit_button.disabled = false
	else:
		question_label.text = "Congratulations! You solved all the riddles!"
		answer_input.hide()
		submit_button.hide()
		feedback_label.text = ""
		deblocheaza_jucatorul()

func _on_submit_pressed() -> void:
	var user_answer = answer_input.text.strip_edges().to_lower()
	var correct_answer = riddles[current_riddle_index]["answer"]
	
	#Dezactivam temporar butonul ca sa nu poata da dublu-click
	submit_button.disabled = true
	answer_input.editable = false
	
	if user_answer == correct_answer:
		feedback_label.text = "Correct! Well done!"
		feedback_label.add_theme_color_override("font_color", Color.GREEN)
		current_riddle_index += 1
		
		#Asteptam inainte sa trecem la urmatoarea ghicitoare
		await get_tree().create_timer(1.5).timeout
		load_riddle()
	else:
		feedback_label.text = "Incorrect! You lost a life."
		feedback_label.add_theme_color_override("font_color", Color.RED)
		Global.vieti -= 1
		
		#Trecem la urmatoarea ghicitoare (sau se va inchide daca erau toate) dupa 1.5 secunde
		current_riddle_index += 1
		await get_tree().create_timer(1.5).timeout
		load_riddle()
		
func deblocheaza_jucatorul():
	var jucator = get_tree().current_scene.get_node_or_null("Jucator")
	
	if jucator:
		jucator.poate_merge = true
		print("Jucătorul a fost deblocat!")
	else:
		print("Eroare: Nu am găsit nodul Jucator!")
	
	#Inchidem fereastra minijocului
	queue_free()
