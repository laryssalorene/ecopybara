extends CharacterBody2D

var speed = 200
var y_min_limit = 0
var y_max_limit = 648
var lixo_coletado = 0
var hp = 3
var pont = 0

func get_hp():
	return hp

func get_coleta():
	if Global.craft == true:
		return lixo_coletado
	return lixo_coletado

func get_pont():
	return pont

func set_speed(x):
	speed = x
	y_min_limit = -200

func coleta_lixo():
	pont += 10
	if Global.craft == false:
		lixo_coletado += 1
		if lixo_coletado >= 5:
			Global.craft = true

func coleta_metal():
	if Global.craft:
		pont += 200
		lixo_coletado = 0
		Global.usouRede = true
		Global.craft = false
	else:
		hp -= 1
		if hp <= 0:
			#Implementar lógica de fim
			get_tree().change_scene_to_file("res://DesafioNorte/desafio_rio.tscn")

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
