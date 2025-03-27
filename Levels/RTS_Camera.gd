extends Node3D

@export_range(0,100,1) var camera_move_speed:float = 20.0

@export_range(0,32,4) var camera_automatic_pan_margin:int = 16
@export_range(0,20,0.5) var camera_automatic_pan_speed:float = 12

var camera_zoom_direction:float = 0
@export_range(0,100,1) var camera_zoom_speed = 40.0
@export_range(0,100,1) var camera_zoom_min = 10
@export_range(0,100,1) var camera_zoom_out = 25
@export_range(0,2,0.1) var camera_zoom_speed_damp:float = 0.92


var camera_can_process:bool = true
var camera_can_move_base:bool = true
var camera_can_zoom:bool = true
var camera_can_automatic_pan: bool = true

@onready var Camera_socket:Node3D = $Camera_socket
@onready var camera:Camera3D = $Camera_socket/Camera3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !camera_can_process:return
	
	camera_base_move(delta)
	camera_zoom_update(delta)
	
func _unhandled_input(event:InputEvent) -> void:
	if event.is_action("camera_zoom_in"):
		camera_zoom_direction = -1
	elif event.is_action("camera_zoom_out"):
		camera_zoom_direction = 1
	
	
func camera_base_move(delta:float) -> void:
	if !camera_can_move_base:return
	var velocity_direction:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("camera_forward"): velocity_direction -= transform.basis.z
	if Input.is_action_pressed("camera_backward"): velocity_direction += transform.basis.z
	if Input.is_action_pressed("camera_right"): velocity_direction += transform.basis.x
	if Input.is_action_pressed("camera_left"): velocity_direction -= transform.basis.x
	print(velocity_direction)
	
	position += velocity_direction.normalized() * delta * camera_move_speed
	
func camera_zoom_update(delta:float) -> void:
	if !camera_can_zoom:return
	
	var new_zoom:float = clamp(camera.position.z + camera_zoom_speed * delta * camera_zoom_direction, camera_zoom_min, camera_zoom_out)
	camera.position.z = new_zoom
	camera_zoom_direction *= camera_zoom_speed_damp
	
func camera_automatic_pan(delta:float) -> void:
	if !camera_can_automatic_pan: return
	
	var viewport_curret:Viewport = get_viewport()
	var pan_direction:Vector2 = Vector2(-1,-1) 
	var viewport_visible_rectangle:Rect2i = Rect2i(viewport_curret.get_visible_rect())
	var viewport_size:Vector2i = viewport_visible_rectangle.size
	
