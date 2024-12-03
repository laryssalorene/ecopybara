extends Area2D

enum ItemType { LIXO_COMUM, METAL_PESADO }
var item_type = ItemType.LIXO_COMUM
var speed = -200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_item_type(novo):
	item_type = novo
	update_cor()

func set_speed(x):
	speed = -x

func update_cor():
	if item_type == ItemType.LIXO_COMUM:
		$ColorRectM.hide()
		$ColorRectL.show()
	elif item_type == ItemType.METAL_PESADO:
		$ColorRectL.hide()
		$ColorRectM.show()

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
