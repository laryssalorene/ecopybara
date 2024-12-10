extends Area2D

enum ItemType { LIXO_COMUM, METAL_PESADO }
var item_type = ItemType.LIXO_COMUM
var speed = -200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

func set_item_type(novo):
	item_type = novo
	update_cor()

func random_number():
	return randi() % 6

func random_numberM():
	return randi() % 2

func set_speed(x):
	speed = -x

func update_cor():
	if item_type == ItemType.LIXO_COMUM:
		var a = random_number()
		if a == 0:
			escondertudo()
			$Lixo.show()
		elif a == 1:
			escondertudo()
			$Lixo2.show()
		elif a == 3:
			escondertudo()
			$Lixo3.show()
		elif a == 4:
			escondertudo()
			$Lixo4.show()
		else:
			escondertudo()
			$Lixo5.show()
	elif item_type == ItemType.METAL_PESADO:
		var b = random_number()
		if b == 0:
			escondertudo()
			$ColorRectL.show()
			$LixoM.show()
		else:
			escondertudo()
			$ColorRectL.show()
			$LixoM2.show()

func escondertudo():
	$ColorRectL.hide()
	$Lixo.hide()
	$Lixo2.hide()
	$Lixo3.hide()
	$Lixo4.hide()
	$Lixo5.hide()
	$LixoM.hide()
	$LixoM2.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x < -50:
		queue_free()

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":
		if item_type == ItemType.LIXO_COMUM:
			body.coleta_lixo()
		elif item_type == ItemType.METAL_PESADO:
			body.coleta_metal()
		queue_free()
