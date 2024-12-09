extends Label

func _ready() -> void:
	EventBus.connect("interaction_raycast_colliding", update_text)

func update_text(data, collider) -> void:
	var final_text: String
	visible = true
	
	if data == null:
		visible = false
		return
	
	for interaction in data:
		if interaction == collider.interactions[-1]:
			final_text += "[{key}] {name}".format({
				"key": interaction.key,
				"name": interaction.name
			})
		else:
			final_text += "[{key}] {name}\n".format({
				"key": interaction.key,
				"name": interaction.name
			})
	
	text = final_text
