extends Node

var message_lifetime := 5.0
var active_logs: Array[Dictionary] = []
var log_label: Label = null

# This variable will store a reference to your player character
var player_node: CharacterBody2D = null

func player_message(text: String) -> void:
	# Print to the regular Godot engine console
	print(text)
	
	# Safety check: make sure the player actually exists in the game right now
	if not player_node or not is_instance_valid(player_node):
		push_warning("Log error: No player character has been registered yet!")
		return
	
	# If the label doesn't exist on the player yet, create it
	if not log_label or not is_instance_valid(log_label):
		_create_label_for_player()
	
	# Calculate expiration time
	var expiry_time = Time.get_ticks_msec() / 1000.0 + message_lifetime
	active_logs.append({"text": text, "expiry": expiry_time})
	
	_update_label_text()

func _create_label_for_player() -> void:
	log_label = Label.new()
	player_node.add_child(log_label)
	
	# 1. Move it further up (Changed Y from -60 to -120)
	# Set X to half of your custom_minimum_size width to center it perfectly
	log_label.position = Vector2(-150, -120) 
	
	# 2. Make the font size bigger (Default is usually around 16)
	log_label.add_theme_font_size_override("font_size", 24)
	
	# Setup visual alignment and text layout
	log_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	log_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	log_label.custom_minimum_size = Vector2(300, 0) # Widen to fit bigger text
func _process(_delta: float) -> void:
	var current_time = Time.get_ticks_msec() / 1000.0
	var changed := false
	
	while active_logs.size() > 0 and current_time >= active_logs[0]["expiry"]:
		active_logs.pop_front()
		changed = true
		
	if changed:
		_update_label_text()

func _update_label_text() -> void:
	if not log_label or not is_instance_valid(log_label):
		return
		
	var lines: Array[String] = []
	for log_item in active_logs:
		lines.append(log_item["text"])
		
	log_label.text = "\n".join(lines)
