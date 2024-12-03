extends Node2D

var player: CharacterBody2D

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	# Certifique-se de que o nó 'Player' existe na cena.
	player = $Player  # O nó Player deve ser um filho de Node2D
	
	if player == null:
		print("O Player não foi encontrado!")
		return

# Chamado a cada frame. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta: float) -> void:
	# Verifica a posição X do Player
	if player.position.x <= 0:
		# Troca a cena para "ribeirinhos.tscn" usando o método correto
		get_tree().change_scene_to_file("res://ribeirinhos.tscn")
	
	if Global.interagir == 1 and Global.apertou == 1:
		get_tree().change_scene_to_file("res://DesafioNorte/desafio_rio.tscn")
		Global.apertou = 0

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	Global.interagir = 1

func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	Global.interagir = 0
