extends Control


func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        get_tree().change_scene_to_file("res://assets/world/world.tscn")
