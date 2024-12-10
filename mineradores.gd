extends Node2D

@export var dialogue_start: String = "start"
@export var dialogue_iara: String = "momento"
@export var dialogue_cipo: String = "cipo"
@export var dialogue_chave: String = "chave"
@export var dialogue_presa: String = "iara"
@export var dialogue_canto: String = "canto"
@export var dialogue_fim: String = "fim"

var parou = 0
var falou = 0
var unica = 0
var camera = 0
var player
var soltou = 0
var cipoo = 0
var inicio = 0
var achou = 0
var musica = 0
var flag = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D2/AnimatedSprite2D.play("default")
	$miner4.hide()
	$AnimatedSprite2D.play("Parada")
	$miner5.hide()
	$miner6.hide()
	$dormiu.hide()
	$dormiu2.hide()
	$dormiu3.hide()
	modula()
	$Bg.hide()
	$AnimatedSprite2D.hide()
	player = $Player
	$ColorRect.show()
	$Player.set_velocidade(0)
	$Player.set_pulo_forca(0)

func modula():
	if inicio == 0:
		inicio = 1
		$Bg.self_modulate.a = 0
		$Bg/Label.self_modulate.a = 0
		$Bg/Label2.self_modulate.a = 0
		$Bg/AnimatedSprite2D.self_modulate.a = 0
		$Bg/Sair.self_modulate.a = 0
		$Bg/Novamente.self_modulate.a = 0
	elif inicio == 2:
		$Bg.self_modulate.a += 0.002
		$Bg/Label.self_modulate.a += 0.002
		$Bg/Label2.self_modulate.a += 0.002
		$Bg/AnimatedSprite2D.self_modulate.a += 0.002
		$Bg/Sair.self_modulate.a += 0.002
		$Bg/Novamente.self_modulate.a += 0.002

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	somchat()
	iluminar()
	escurecer()
	almoco()
	cameraZ()
	cipo()
	soltar()
	telafim()
	modula()
	timerPraacabar()
	if State.danca == true:
		State.danca = false
		$Timer7.start()
	if soltou == 1:
		player.set_velocidade(200*(player.position.y/560))
		player.set_pulo_forca(500*(player.position.y/560))
	player.scale = Vector2((player.position.y/560), (player.position.y/560))
	if player.position.y <= 180 and cipoo == 0:
		cipoo = 1
		DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_cipo)

func soltar():
	if State.solto == true:
		State.solto = false
		falou = 1
		$Timer4.start()

func iluminar():
	if $ColorRect.self_modulate.a >= 0 and parou == 0:
		$ColorRect.self_modulate.a -= 0.005
	else:
		if unica == 0:
			DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_start)
			unica = 1
		parou = 1

func cipo():
	if State.cipo == "sim":
		State.cipo = "nao"
		cipoo = 0
		player.position.x = 675
		player.position.y = 260

func escurecer():
	if falou == 1 and $ColorRect.self_modulate.a <= 1:
		$ColorRect.self_modulate.a += 0.01
	else:
		falou = 0

func acabou():
	$Canto.play()
	$AnimatedSprite2D.play("Cantando")
	$Timer5.start()

func almoco():
	if State.foram == "sim":
		falou = 1
		State.foram = "nao"
		$Timer.start()

func _on_timer_timeout() -> void:
	parou = 0
	$miner1.hide()
	$miner2.hide()
	$miner3.hide()
	$Timer2.start()

func cameraZ():
	if camera == 1:
		$Camera2D.zoom -= Vector2(0.001, 0.001)

func _on_timer_2_timeout() -> void:
	camera = 1
	$Camera2D.set_enabled(true)
	$Timer3.start()
	DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_iara)

func _on_timer_3_timeout() -> void:
	soltou = 1
	camera = 0
	$Camera2D.set_enabled(false)
	$Player.set_velocidade(200)

func somchat():
	if State.som == "nao":
		$"Chat-talking".stop()
	if State.som == "sim" and musica == 0:
		$"Chat-talking".play()
		musica = 1
	if State.som == "nao" and musica == 1:
		musica = 0

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if achou == 0:
		achou = 1
		$Area2D.hide()
		DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_chave)

func _on_area_2d_2_body_entered(body: CharacterBody2D) -> void:
	DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_presa)

func telafim():
	if State.fim == true:
		inicio = 2
		$Bg.show()

func _on_timer_4_timeout() -> void:
	$Area2D2.hide()
	$AnimatedSprite2D.show()
	$miner4.show()
	$miner5.show()
	$miner6.show()
	player.position.x = 915
	player.position.y = 545
	player.scale.x = -1
	soltou = 0
	$Player.set_velocidade(0)
	parou = 0
	if flag == 0:
		flag = 1
		DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_canto)

func timerPraacabar():
	if State.acabou == true:
		State.acabou = false
		$Timer6.start()

func _on_timer_5_timeout() -> void:
	$miner4.hide()
	$miner5.hide()
	$miner6.hide()
	$dormiu.show()
	$dormiu2.show()
	$dormiu3.show()
	$Canto.stop()	
	$AnimatedSprite2D.play("Parada")
	DialogueManager.show_dialogue_balloon(load("res://dialogue/mineradores.dialogue"), dialogue_fim)

func _on_novamente_pressed() -> void:
	get_tree().change_scene_to_file("res://MainScreen.gd")

func _on_sair_pressed() -> void:
	get_tree().quit()

func _on_timer_6_timeout() -> void:
	acabou()

func _on_timer_7_timeout() -> void:
	soltou = 0
