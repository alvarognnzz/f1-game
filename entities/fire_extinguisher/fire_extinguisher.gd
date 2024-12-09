extends RigidBody3D

@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

@export var player: CharacterBody3D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("use"):
		gpu_particles_3d.emitting = true
	else:
		gpu_particles_3d.emitting = false
	
	if Input.is_action_just_pressed("drop"):
		freeze = false
		var direction = (global_transform.origin - player.global_transform.origin).normalized()
		var impulse = direction * 2
		apply_central_impulse(impulse)
		reparent(player.world)
