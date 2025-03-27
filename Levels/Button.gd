extends Button

signal pressed_signal

func _ready():
	connect("pressed", Callable(self, "_on_Button_pressed"))

func _on_Button_pressed():
	emit_signal("pressed_signal")
