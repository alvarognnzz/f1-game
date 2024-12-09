extends Control

@export var radius: float = 2.0
@export var color: Color = Color.WHITE

func _ready() -> void:
	EventBus.connect("interaction_raycast_colliding", visibility)

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(get_viewport_rect().size / 2, radius, color)

func visibility(data, _collider) -> void:
	if data == null:
		visible = true
	else:
		visible = false
