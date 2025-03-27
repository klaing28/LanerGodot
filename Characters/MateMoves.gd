extends Node3D

# Define the start (point A) and end (point B) positions
var start_position = Vector3(0, 0, 0)
var end_position = Vector3(10, 0, 0)

# Define the speed of the movement
var speed = 5.0  # Units per second

# To store the velocity
var velocity = Vector3.ZERO

func _ready():
	# Set the initial position to the start position
	global_transform.origin = start_position

func _integrate_forces(state):
	if global_transform.origin.distance_to(end_position) > 0.1:
		# Calculate the direction vector
		var direction = (end_position - global_transform.origin).normalized()
		
		# Calculate the velocity required to move towards the end position
		velocity = direction * speed
		
		# Apply the velocity to the RigidBody
		state.linear_velocity = velocity
	else:
		# Stop the RigidBody
		state.linear_velocity = Vector3.ZERO
		self.sleeping = true
