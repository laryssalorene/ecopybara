extends Node2D

var player: CharacterBody2D
var parou = 0

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	player = $Player  # O nó Player deve ser um filho de Node2D
	$ColorRect.show()
	
	if player == null:
		print("O Player não foi encontrado!")
		return

# Chamado a cada frame. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta: float) -> void:
	iluminar()
	if Global.apertou == 1:
		Global.apertou = 0
		Global.local = player.position.y
		get_tree().change_scene_to_file("res://DesafioNorte/desafio_rio.tscn")

func iluminar():
	if $ColorRect.self_modulate.a >= 0 and parou == 0:
		$ColorRect.self_modulate.a -= 0.005
	else:
		parou = 1
