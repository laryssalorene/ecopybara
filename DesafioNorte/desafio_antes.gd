extends Node2D

var player: CharacterBody2D
var parou = 0
var musica = 0

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	player = $Player  # O nó Player deve ser um filho de Node2D
	$Player/Nado.play("default")
	$ColorRect.show()
	$peixe1/Fala.play("default")
	if player == null:
		print("O Player não foi encontrado!")
		return

# Chamado a cada frame. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta: float) -> void:
	somchat()
	iluminar()
	if Global.apertou == 1:
		Global.apertou = 0
		Global.local = player.position.y
		get_tree().change_scene_to_file("res://DesafioNorte/desafio_rio.tscn")

func somchat():
	if State.som == "nao":
		$"Chat-talking".stop()
	if State.som == "sim" and musica == 0:
		$"Chat-talking".play()
		musica = 1
	if State.som == "nao" and musica == 1:
		musica = 0

func iluminar():
	if $ColorRect.self_modulate.a >= 0 and parou == 0:
		$ColorRect.self_modulate.a -= 0.005
	else:
		parou = 1
