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
	if Global.interagir == 1 and Global.apertou == 1:
		falou = 1
		$Timer.start()
		Global.apertou = 0
	iluminar()
	escurecer()
	#fogo()

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	Global.interagir = 0

func _on_iara_body_entered(body: Node2D) -> void:
	Global.interagir = 1

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://ribeirinhos.tscn")

func fogo():
	if fogoL == 1 and $ColorRect2.self_modulate.a <= 0.08:
		$ColorRect2.self_modulate.a += 0.0015
		$ColorRect3.self_modulate.a += 0.0015
	elif fogoL == 1 and $ColorRect2.self_modulate.a > 0.08:
		fogoL = 0
	elif fogoL == 0 and $ColorRect2.self_modulate.a >= 0.010:
		$ColorRect2.self_modulate.a -= 0.0015
		$ColorRect3.self_modulate.a -= 0.0015
	elif fogoL == 0 and $ColorRect2.self_modulate.a < 0.010:
		fogoL = 1
