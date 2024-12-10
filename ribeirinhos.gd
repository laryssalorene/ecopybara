extends Node2D

var player: CharacterBody2D
var last_y_position: float = 0.0
var parou = 0
var falou = 0
var mudar = 0
var pulo = false
var musica = 0

func _ready() -> void:
	if get_tree().get_current_scene().name == "ribeirinhos":
		$crianca/AnimatedSprite2D.play("default")
	player = $Player
	$ColorRect.show()
	
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
		if get_tree().get_current_scene().name == "ribeirinhos":
			$crianca/AnimatedSprite2D.hide()

func _process(delta: float) -> void:
	somchat()
	pulinho()
	iluminar()
	escurecer()
	player.set_velocidade(200*(player.position.y/560))
	player.set_pulo_forca(500*(player.position.y/560))
	player.scale = Vector2((player.position.y/560), (player.position.y/560))
	
	if Global.apertou == 2:
		Global.apertou = 0
		$Timer.start()
		falou = 1
	
	if mudar == 1:
		mudar = 2
		$Timer2.start()
		falou = 1
	
	if player.position.y <= 285 and get_tree().get_current_scene().name == "ribeirinhos1":
		if mudar != 2:
			mudar = 1

func somchat():
	if State.som == "nao":
		$"Chat-talking".stop()
	if State.som == "sim" and musica == 0:
		$"Chat-talking".play()
		musica = 1
	if State.som == "nao" and musica == 1:
		musica = 0

func pulinho():
	if pulo and $Player/AnimatedSprite2D.position.y > -60 and $Player.position.y < 540:
		$Player/AnimatedSprite2D.position.y -= 4
	elif !pulo and $Player/AnimatedSprite2D.position.y < 0:
		$Player/AnimatedSprite2D.position.y += 4
	if Input.is_action_pressed("ui_down") and get_tree().get_current_scene().name == "ribeirinhos" and $Player.is_on_floor():
		pulo = true
		$TimerPuloCima.start()
		if $Player.position.y < 540:
			$Player/Pulo.play()

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://ribeirinhosFase.tscn")

func _on_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://DesafioNorte/desafio_antes.tscn")

func _on_timer_pulo_cima_timeout() -> void:
	pulo = false
