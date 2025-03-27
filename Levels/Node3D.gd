extends Node3D

var MovableObject = preload("res://Characters/basicMate.tscn")
# Preload the MovableObject scene
func _ready():
	var button = $button
	
func _process(delta):
	pass

func _on_Button_pressed():
	# Instance the MovableObject scene
	pass


func _on_button_pressed():
	var instance = MovableObject.instantiate()
	instance.global_transform.origin = Vector3(0, 0, 0)
	add_child(instance) # Replace with function body.
