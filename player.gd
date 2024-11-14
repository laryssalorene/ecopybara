extends CharacterBody2D

@onready var actionable_finder: Area2D = $Direction/ActionableFinder 
# Variáveis de controle de movimento
@export var velocidade = 200  # Velocidade horizontal do personagem
@export var pulo_forca = 500  # Força do pulo
@export var gravidade = 800  # Gravidade aplicada ao personagem

# Limites da fase
@export var limite_esquerda = 0  # Limite esquerdo da fase
@export var limite_direita = 1152  # Limite direito da fase
@export var limite_superior = 0  # Limite superior (normalmente o chão)
@export var limite_inferior = 648  # Limite inferior (normalmente a altura da fase)

var movimento = Vector2()  # Vetor que armazena o movimento atual

func _ready():
	pass  # Função chamada quando a cena está pronta

func _process(delta):
	_movimentar_personagem(delta)
	_manter_dentro_dos_limites()

func get_velocidade():
	return velocidade

func set_velocidade(x):
	velocidade = x

func get_pulo_forca():
	return pulo_forca

func set_pulo_forca(x):
	pulo_forca = x

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_interact2"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

# Função para movimentar o personagem
func _movimentar_personagem(delta):
	# Resetar o movimento horizontal
	movimento.x = 0
	
	# Verificar se as teclas de movimento estão sendo pressionadas
	if Input.is_action_pressed("ui_interact"):
		Global.apertou = 1
		await get_tree().create_timer(0.1).timeout
		Global.apertou = 0
	if Input.is_action_pressed("ui_right"):
		movimento.x += velocidade
		$AnimatedSprite2D.play("Andar")
		$AnimatedSprite2D.scale.x = -abs($AnimatedSprite2D.scale.x)
	elif Input.is_action_pressed("ui_left"):
		movimento.x -= velocidade
		$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x)
		$AnimatedSprite2D.play("Andar")
	elif movimento.x == 0:
		$AnimatedSprite2D.play("Parada")

	# Verificar se o personagem está no chão e se a tecla de pulo foi pressionada
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -pulo_forca
	
	# Aplicar a gravidade
	if not is_on_floor():
		velocity.y += gravidade * delta
	
	if Input.is_action_just_pressed("ui_down"):
		collision_mask = 0
		await get_tree().create_timer(0.1).timeout
		collision_mask = 1
	
	# Usar o movimento calculado para mover o personagem
	velocity.x = movimento.x
	move_and_slide()

# Função para garantir que o player não saia dos limites da fase
func _manter_dentro_dos_limites():
	# Limitar a posição X do player
	if position.x < limite_esquerda:
		position.x = limite_esquerda
	elif position.x > limite_direita:
		position.x = limite_direita

	# Limitar a posição Y do player (não permitir cair abaixo do limite inferior)
	if position.y > limite_inferior:
		position.y = limite_inferior
