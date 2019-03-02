extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector2(0, -1)
const SLOPE_STOP = 5

var velocity = Vector2()
var move_speed = 200
var gravity = 600
var jump_velocity = -300
var is_grounded
#anim_player.play("Idle")

onready var raycasts = $Rayman

func _physics_process(delta):
	_get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	is_grounded = _check_is_grounded()
	_assign_animation()
		
		
		
func _input(event):
	#Quit
	if event.is_action_pressed("ui_quit"):
		get_tree().quit()
	#Jump
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_velocity	
		
		
func _get_input():
	var move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, _get_h_weight())
	#if move_direction !=0:
		#$Body.scale.x = move_direction
		
	if move_direction < 0:
		$AnimatedSprite.flip_h = true
	elif move_direction > 0:
		$AnimatedSprite.flip_h = false
				
func _get_h_weight():
	return 0.1 if is_grounded else  0.05
		
		
		
func _check_is_grounded():
#	for raycast in raycasts.get_children():
#		if raycast.is_colliding():
#			print ("meow")
#			return true
#	return false
	return is_on_floor()
#
	
	
func _assign_animation():
	
	var anim = "Idle"

	if !is_grounded:
		anim = "Jump"
	elif velocity.x < -2 or velocity.x > 2:
		anim = "Run"
	
	print(anim)

#	if anim_player.assigned_animation != anim:
#		anim_player.play(anim)
	$AnimatedSprite.play(anim)
	
	
	
	