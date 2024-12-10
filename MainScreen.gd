extends CanvasLayer

var info = 0
var cred = 0

func _ready():
	pass

func _on_Iniciar_pressed():
	get_tree().change_scene_to_file("res://MainScene.tscn")

func _on_Info_pressed():
	if info == 0:
		$Info2.show()
		info = 1
	else:
		$Info2.hide()
		info = 0

func _on_sair_pressed() -> void:
	get_tree().quit()


func _on_creditos_pressed() -> void:
	if cred == 0:
		$Creditos2.show()
		cred = 1
	else:
		$Creditos2.hide()
		cred = 0
