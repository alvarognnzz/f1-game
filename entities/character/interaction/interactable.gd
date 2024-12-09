extends Node

var interactions = [
	{
		"id": 0,
		"key": "E",
		"input": "interact",
		"name": "Interact",
	}
]
var executable_interactions = []

var colliding := false

func _ready() -> void:
	if "interactions" in get_parent():
		interactions = get_parent().interactions
	
	EventBus.connect("interaction_raycast_colliding", handle_data)

func handle_data(data, collider):
	if collider == null:
		colliding = false
		executable_interactions = []
	else:
		colliding = true
	
	if data != null:
		for interaction in interactions:
			for item in data:
				if interaction == item and not executable_interactions.has(interaction):
					executable_interactions.append(interaction)

func _physics_process(delta: float) -> void:
	for interaction in executable_interactions:
		if Input.is_action_just_pressed(interaction.input) and colliding:
			if get_parent().has_method("interact"):
				get_parent().interact(interaction.id)
