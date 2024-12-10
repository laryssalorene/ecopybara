extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control.hide()
	escolha()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func escolha():
	if get_tree().get_current_scene().name == "MainScene":
		$Control/Texto.text = "Você foi invocada, escolhida para representar a natureza. Sua aventura começa aqui. Interaja com a estátua para encontrar o seu destino."
	elif get_tree().get_current_scene().name == "ribeirinhos":
		$Control/Texto.text = "Seu primeiro destino: quem sabe algum desses ribeirinhos possa ajudá-la?"
	elif get_tree().get_current_scene().name == "ribeirinhos1":
		$Control/Texto.text = "Vá em direção ao rio, para o NORTE! É lá que você encontrará o seu primeiro desafio!"
	elif get_tree().get_current_scene().name == "DesafioRio":
		$Control/SetaE.hide()
		$Control/SetaD.hide()
		$Control/Texto.text = "Este peixe parece precisar de ajuda. Escute bem o que ele tem a dizer; talvez ele saiba onde está a Iara."
	elif get_tree().get_current_scene().name == "DesafioRio2":
		$Control/SetaE.hide()
		$Control/SetaD.hide()
		$Control/Texto.text = "CUIDADO! Desvie dos metais poluentes, a menos que você possa coletá-los! Recolha 5 lixos comuns para conseguir coletar um destes metais"

func _on_button_mouse_entered() -> void:
	$Button.self_modulate.a = 0
	$Control.show()

func _on_button_mouse_exited() -> void:
	pass

func _on_color_rect_mouse_exited() -> void:
	$Control.hide()
	$Button.self_modulate.a = 1
