# Attach this script to the Area2D of any interactable object
# The parent node must have a script attached to it with a interact() function
# The parent node must also have a label

# This script handles the ineract function and showing/hiding the labels

class_name Interactable
extends Area2D

@export var prompt_label: Label

# Shows the text "[E]" in the prompt
func show_prompt():
	# make sure that the prompt is available
	if prompt_label:
		get_parent().label.text = "[E]"
		get_parent().label.visible = true

# hides the prompt
func hide_prompt():
	if prompt_label:
		get_parent().label.visible = false

# triggers the parent's interact function
func interact():
	get_parent().interact()
