extends Area2D
signal hit
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var force_field # Boolean to store force field activation
func _ready():
	screen_size = get_viewport_rect().size
	hide()
	if not force_field:
		$ForceField.visible = false
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1 
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("force_field"):
		force_field = true
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.flip_v = velocity.y > 0
func _on_body_entered(body):
	if not force_field:
		hide() # Player disappears after being hit.
		$AnimatedSprite2D.animation = "up"
		hit.emit()
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true) # Replace with function body.
	else:
		$ForceField.visible = true
		$ForceField.animation = "default"
		$ForceField.play()
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
