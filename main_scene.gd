extends Node2D

@export var player_pos_x = 100
@export var player_pos_y = 200

var mudarc = 0
var parou = 0
var falou = 0
var fogoL = 1

func _ready():
	_iniciar_player()
	$ColorRect.show()
	$Iara/AnimatedSprite2D.play("default")

func iluminar():
	if $ColorRect.self_modulate.a >= 0 and parou == 0:
		$ColorRect.self_modulate.a -= 0.005
	else:
		parou = 1

func escurecer():
	if falou == 1:
		$ColorRect.self_modulate.a += 0.01

func _iniciar_player():
	var player = $Player
	if player:
		player.position = Vector2(100, 580)

func _process(delta):
	iluminar()
	escurecer()
	if Global.apertou == 1:
		falou = 1
		$Timer.start()
		Global.apertou = 0

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://ribeirinhos.tscn")
