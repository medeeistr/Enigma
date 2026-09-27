extends TextureRect

@export var numar_viata: int = 1

func _process(_delta):
	#Daca viata a fost pierduta, o ascundem
	if numar_viata > Global.vieti:
		visible = false
	else:
		visible = true
