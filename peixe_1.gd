extends CharacterBody2D

# Constantes e variáveis de controle
@export var velocidade = 100  # Velocidade do peixe
@export var roaming_area = Vector2(300, 200)  # Área de roaming
var dir = Vector2(1, 0)  # Direção inicial
var is_roaming = true
var roaming_bounds = Rect2(Vector2.ZERO, Vector2.ZERO)
@export var limite_x_min = 575
@export var limite_x_max = 1125
@export var limite_y_min = 590
@export var limite_y_max = 630

# Estados
enum {
	IDLE,
	NEW_DIR,
	MOVE
}
var current_state = IDLE

func _ready():
	randomize()
	roaming_bounds = Rect2(position - roaming_area / 2, roaming_area)
	_mudar_direcao()

func _process(delta: float) -> void:
	if is_roaming:
		_mover(delta)

func _mover(delta: float) -> void:
	# Movimento do peixe
	if current_state == MOVE:
		velocity = dir * velocidade
		move_and_slide()
	
	if position.x < limite_x_min:
		position.x = limite_x_min
		dir.x = abs(dir.x)  # Muda direção para a direita
	elif position.x > limite_x_max:
		position.x = limite_x_max
		dir.x = -abs(dir.x)  # Muda direção para a esquerda

	if position.y < limite_y_min:
		dir.y = abs(dir.y)  # Muda direção para baixo
	elif position.y > limite_y_max:
		dir.y = -abs(dir.y)  # Muda direção para cima

	# Controle de animações
	if dir.x < 0:
		$AnimatedSprite2D.play("l1")
	elif dir.x > 0:
		$AnimatedSprite2D.play("l2")

func _mudar_direcao():
	current_state = NEW_DIR
	dir = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	current_state = MOVE

	# Agendar a próxima mudança de direção
	await get_tree().create_timer(randf_range(1.5, 3.0)).timeout
	_mudar_direcao()

func _reverter_direcao():
	# Faz o peixe mudar de direção quando sair dos limites
	dir = -dir
