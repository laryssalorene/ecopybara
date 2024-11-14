extends Node2D

var player: CharacterBody2D
var last_y_position: float = 0.0  # Variável para armazenar a última posição Y

# Chamado quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	# Obtém o nó do Player, que deve ser um CharacterBody2D.
	player = $Player  # Supondo que o Player seja um nó filho de Node2D
	
	if player == null:
		print("O Player não foi encontrado!")
		return
	
	# Define a escala inicial para 1,1
	player.scale = Vector2(1, 1)
	last_y_position = player.position.y

# Chamado a cada frame. 'delta' é o tempo decorrido desde o quadro anterior.
func _process(delta: float) -> void:
	player.set_velocidade(200*(player.position.y/560))
	player.set_pulo_forca(500*(player.position.y/560))
	player.scale = Vector2((player.position.y/560), (player.position.y/560))
	
	# Atualiza a última posição Y para o próximo quadro
	last_y_position = player.position.y
	
	# Verifica se a posição X do Player é menor que 0
	if player.position.x >= 1140:
		# Troca a cena para "f1.tscn"
		get_tree().change_scene_to_file("res://f1.tscn")
