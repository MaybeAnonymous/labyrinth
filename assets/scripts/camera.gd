extends Camera2D

var current_screen: Vector2 = Vector2()

@onready var screen_size: Vector2 = get_viewport().get_visible_rect().size


func _ready() -> void:
    top_level = true
    global_position = Vector2()
    update_screen(current_screen)

func _process(_delta: float) -> void:
    var parent_screen: Vector2 = (get_parent().global_position / screen_size).floor()
    if not parent_screen.is_equal_approx(current_screen):
        update_screen(parent_screen)

func update_screen(new_screen: Vector2) -> void:
    current_screen = new_screen
    global_position = current_screen * screen_size + (screen_size * 0.5)
