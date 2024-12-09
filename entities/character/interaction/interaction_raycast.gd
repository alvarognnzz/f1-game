extends RayCast3D

var colliding := false
var data := []
var interactable: Node 

func _process(delta: float) -> void:
	if is_colliding():
		check_collider(get_collider())
	
	if not is_colliding() and colliding == true:
		colliding = false
		EventBus.interaction_raycast_colliding.emit(null, null)
	
	if is_colliding() and not is_interactable(get_collider()) and colliding == true:
		colliding = false
		EventBus.interaction_raycast_colliding.emit(null, null)
	
	if data != [] and colliding:
		EventBus.interaction_raycast_colliding.emit(data, interactable)
		data = []

func is_interactable(collider) -> bool:
	for child in collider.get_children():
		if child.is_in_group("interactable"):
			return true
	
	return false

func check_collider(collider) -> void:
	for child in collider.get_children():
		if child.is_in_group("interactable"):
			colliding = true
			interactable = child
			
			for interaction in child.interactions:
				if interaction.has("custom_condition"):
					if interaction.custom_condition:
						data.append(interaction)
				else:
					data.append(interaction)
