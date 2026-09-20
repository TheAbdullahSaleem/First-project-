extends TextureRect

var active_crop = null
func _ready():
	visible = false
	SignalBus.crop_mutated.connect(_on_crop_mutated)

func _on_crop_mutated(crop: Node2D):
	active_crop = crop
	visible = true
	get_tree().paused = true


func _on_button_3_pressed() -> void:
	close_ui()
	print("player made a choice")

func _on_button_2_pressed() -> void:
	close_ui()
	print("player made a choice")

func _on_button_pressed() -> void:
	if active_crop != null:
		active_crop.queue_free()
	close_ui()
	print("player destroyed the crop")

func close_ui():
	visible = false
	get_tree().paused = false
