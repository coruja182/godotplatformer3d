class_name Coin extends Area3D


@export var spin_speed : float = 2.0
@export var bob_height : float = 0.2
@export var bob_speed : float = 5.0

var _start_y : float
var _t_counter : float = 0.0


func _ready() -> void:
	_start_y = global_position.y


func _process(delta: float) -> void:
	rotate(Vector3.UP, 2 * delta)
	bob(delta)


func bob(delta: float) -> void:
	_t_counter += delta
	var _calculated_bob = (sin(_t_counter * bob_speed) + 1) / 2
	global_position.y = _start_y + (_calculated_bob * bob_height)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.add_score(1)
		queue_free()
