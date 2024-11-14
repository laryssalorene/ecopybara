extends Node2D

@export var player_pos_x = 100
@export var player_pos_y = 200

var mudarc = 0

func _ready():
	_iniciar_player()

func _iniciar_player():
	var player = $Player
	if player:
		player.position = Vector2(100, 580)

func _process(delta):
	if Global.interagir == 1 and Global.apertou == 1:
		get_tree().change_scene_to_file("res://ribeirinhos.tscn")
		Global.apertou = 0

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	Global.interagir = 0

func _on_iara_body_entered(body: Node2D) -> void:
	Global.interagir = 1
