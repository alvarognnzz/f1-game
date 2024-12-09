extends Node

func _on_start_timer_timeout() -> void:
	EventBus.start_race.emit()
