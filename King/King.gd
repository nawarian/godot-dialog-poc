extends Area2D

enum Direction {
	LEFT,
	RIGHT,
}
onready var direction = Direction.RIGHT

onready var anim = $AnimatedSprite
onready var emotes = $Emotes
onready var player: KinematicBody2D = get_parent().get_node_or_null("Player")

var main_dialogue = preload("res://dialogues/MainKingDialogue.tres")

func _ready():
	emotes.play("awaiting")

func _process(delta):
	if player.position.x < position.x:
		direction = Direction.LEFT
	elif player.position.x > position.x:
		direction = Direction.RIGHT
	
	if direction == Direction.LEFT:
		anim.flip_h = true
	else:
		anim.flip_h = false

func _on_body_entered(body):
	if body == player:
		if not DialogueManager.is_dialogue_running:
			DialogueManager.show_example_dialogue_balloon("main_king_dialogue", main_dialogue)
		emotes.play("alert")

func _on_body_exited(body):
	if body == player:
		emotes.play("awaiting")
