class_name EnemySpike extends Area3D


@export var move_speed : float = 2
@export var move_direction : Vector3

var start_pos : Vector3
var target_pos : Vector3


func _ready() -> void:
	start_pos = global_position
	target_pos = start_pos + move_direction


func _process(delta: float) -> void:
	global_position = global_position.move_toward(target_pos, move_speed * delta)

	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.game_over()
