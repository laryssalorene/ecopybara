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
var speed = 200
var movimento = Vector2()  # Vetor que armazena o movimento atual
var y_min_limit = 0
var y_max_limit = 648

func _ready():
	pass
	#$AnimatedSprite2D.scale.x = -abs($AnimatedSprite2D.scale.x)

func _process(delta):
	var movimento = Vector2()
	if Input.is_action_pressed("ui_up"):
		movimento.y -= speed
	elif Input.is_action_pressed("ui_down"):
		movimento.y += speed
	velocity.y = movimento.y
	move_and_slide()
	
	if position.y < y_min_limit:
		position.y = y_min_limit
	elif position.y > y_max_limit:
		position.y = y_max_limit

func get_velocidade():
	return velocidade

func set_velocidade(x):
	velocidade = x

func get_pulo_forca():
	return pulo_forca

func set_pulo_forca(x):
	pulo_forca = x

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
