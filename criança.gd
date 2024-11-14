extends Area2D

@export var dialogue_start: String = "start"

func action() -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/crianca.dialogue"), dialogue_start)
