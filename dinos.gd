extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_timer_timeout():
	var dinoScene = load("res://mort.tscn")
	var node = dinoScene.instance()
	add_child(node)
