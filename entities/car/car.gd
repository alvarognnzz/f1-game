extends PathFollow3D

@onready var fixing_path: Path3D = $"../../FixingPath"
@onready var car_path: Path3D = $".."
@onready var car_path_2: Path3D = $"../../CarPath2"

@export var min_speed: float = 10
@export var max_speed: float = 45
@export var individual_progress: float

enum State { RACING, FIXING, EXITING_FIXING }
var current_state: State = State.RACING

func _ready() -> void:
	progress_ratio = individual_progress
	EventBus.start_race.connect(start_race)
	EventBus.send_to_race.connect(send_to_race)

func _process(delta: float) -> void:
	match current_state:
		State.RACING:
			progress += -delta * max_speed
		State.FIXING:
			if progress_ratio < 0.45:
				progress += delta * (min_speed if progress_ratio > 0.16 else max_speed)
		State.EXITING_FIXING:
			progress += delta * min_speed

func start_race() -> void:
	current_state = State.RACING

func _on_fixing_area_body_entered(body: Node3D) -> void:
	if get_parent().is_in_group("car_path_1") and fixing_path.get_child_count() == 0:
		if randi() % 2 == 0 and current_state == State.RACING:
			progress_ratio = 0
			use_model_front = true
			reparent(fixing_path)
			current_state = State.FIXING

func send_to_race() -> void:
	if current_state == State.FIXING and progress_ratio > 0.45:
		current_state = State.EXITING_FIXING

func _on_exiting_fixing_area_body_entered(body: Node3D) -> void:
	if current_state == State.EXITING_FIXING:
		reparent(car_path)
		use_model_front = false
		current_state = State.RACING
