extends Node2D

var player: CharacterBody2D
var last_y_position: float = 0.0
var parou = 0
var falou = 0
var mudar = 0

func _ready() -> void:
	player = $Player
	
	if player == null:
		print("O Player não foi encontrado!")
		return
	
	player.scale = Vector2(1, 1)
	last_y_position = player.position.y

func iluminar():
	if $ColorRect.self_modulate.a >= 0 and parou == 0:
		$ColorRect.self_modulate.a -= 0.005
	else:
		parou = 1

func escurecer():
	if falou == 1:
		$ColorRect.self_modulate.a += 0.01

func _process(delta: float) -> void:
	iluminar()
	escurecer()
	player.set_velocidade(200*(player.position.y/560))
	player.scale = Vector2((player.position.y/560), (player.position.y/560))
	
	if Input.is_action_pressed("ui_interact"):
		$Timer.start()
		falou = 1
	
	if mudar == 1:
		mudar = 2
		$Timer2.start()
		falou = 1
	
	if player.position.y <= 285:
		if mudar != 2:
			mudar = 1

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://ribeirinhosFase.tscn")

func _on_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://DesafioNorte/desafio_antes.tscn")
