extends Area2D

@export var dialogue_start: String = "start"

func action() -> void:
	var x = get_tree().get_current_scene().name
	print(get_tree().get_current_scene().name)
	if str(x) == "DesafioRio":
		DialogueManager.show_dialogue_balloon(load("res://dialogue/peixe.dialogue"), dialogue_start)
	elif str(x) == "ribeirinhos":
		DialogueManager.show_dialogue_balloon(load("res://dialogue/crianca.dialogue"), dialogue_start)
	elif str(x) == "MainScene":
		DialogueManager.show_dialogue_balloon(load("res://dialogue/estatua.dialogue"), dialogue_start)
