extends Area2D

onready var sprite = $AnimatedSprite
onready var player: KinematicBody2D = get_parent().get_node_or_null("Player")

func _ready():
	pass # Replace with function body.

func _process(delta):
	if player.position.x < position.x:
		sprite.flip_h = true
	elif player.position.x > position.x:
		sprite.flip_h = false
