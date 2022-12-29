class_name Player
extends CharacterBody2D

# The size of the movement grid.
const GRID: Vector2 = Vector2(16, 16)
const AUTO_MOVE_DELAY: float = 0.15

# The possible movement directions.
const INPUTS := { 
    "right": Vector2.RIGHT,
    "left": Vector2.LEFT,
    "down": Vector2.DOWN,
    "up": Vector2.UP
}

var current_dir: Vector2
var until_auto_move: float = AUTO_MOVE_DELAY

@onready var collision_ray := $CollisionRay as RayCast2D
@onready var death_timer := $DeathTimer as Timer
@onready var black_screen := $CanvasLayer/Black as ColorRect


func _ready() -> void:
    black_screen.hide()


func _process(delta) -> void:
    until_auto_move += delta

    # For every value in INPUTS:
    for dir in INPUTS.keys():
        if Input.is_action_just_pressed(dir):
            move(dir, collision_ray)
            until_auto_move = 0
        elif Input.is_action_pressed(dir) and until_auto_move > AUTO_MOVE_DELAY:
            move(dir, collision_ray)
            until_auto_move = 0


func move(dir: String, ray: RayCast2D) -> void:
    ray.target_position = INPUTS[dir] * GRID

    ray.force_raycast_update()

    if not ray.is_colliding(): 
        position += ray.target_position


func _on_death_detector_area_entered(area: Area2D) -> void:
    if area.is_in_group("death"):
        black_screen.show()
        death_timer.start()


func _on_death_timer_timeout() -> void:
    # Go to the menu screen.
    get_tree().change_scene_to_file("res://assets/gui/main_menu/main_menu.tscn")
