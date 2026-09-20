class_name Interactable
extends Area2D
@export var prompt_label: Label
func show_prompt():
	if prompt_label:
		get_parent().label.text = "[E]"
		get_parent().label.visible = true
	
func hide_prompt():
	if prompt_label:
		get_parent().label.visible = false

func interact():
	get_parent().interact()
