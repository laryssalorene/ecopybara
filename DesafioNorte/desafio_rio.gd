extends Node2D

var lixo_scene: PackedScene = preload("res://DesafioNorte/lixo.tscn")
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $Player
	player.position.y = Global.local
	randomize()
	pass

func _spawn_item():
	var variacao = min(floor(1 + player.get_pont()/100), 5)
	var item = lixo_scene.instantiate()
	add_child(item)
	item.position = Vector2(1152, randf_range(50, 600))
	if randi_range(1, 7 - variacao) == 1:
		item.set_item_type(item.ItemType.METAL_PESADO)
	else:
		item.set_item_type(item.ItemType.LIXO_COMUM)
	if (player.get_pont() >= 200):
		item.set_speed(200 + player.get_pont()/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hp(player.get_hp())
	coleta(player.get_coleta())
	pont()
	if player.get_pont() >= 600:
		cabo()

func cabo():
	player.set_speed(0)
	player.position.y -= 1
	if player.position.y <= -50:
		get_tree().quit() #Alterar para mudança de fase

func _on_timer_timeout() -> void:
	if (player.get_pont() < 600):
		_spawn_item()
	else:
		pass

func pont():
	$Labelp.text = str(player.get_pont())

func coleta(x):
	if Global.usouRede == true:
		$Labelc/Craft1.play("vazio")
		$Labelc/Craft2.play("vazio")
		$Labelc/Craft3.play("vazio")
		$Labelc/Craft4.play("vazio")
		$Labelc/Craft5.play("vazio")
		Global.usouRede = false
	if x == 5:
		$Labelc/Craft5.play("cheio")
	elif x == 4:
		$Labelc/Craft4.play("cheio")
	elif x == 3:
		$Labelc/Craft3.play("cheio")
	elif x == 2:
		$Labelc/Craft2.play("cheio")
	elif x == 1:
		$Labelc/Craft1.play("cheio")

func hp(x):
	if x == 2:
		$Labelh/Coracao3.play("vazio")
	elif x == 1:
		$Labelh/Coracao2.play("vazio")
	elif x == 0:
		$Labelh/Coracao1.play("vazio")
