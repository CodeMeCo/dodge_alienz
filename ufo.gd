extends RigidBody2D

var screen_size # Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func start():
	position.x = screen_size.x/2
	position.y = screen_size.y/2
#                          Pascal is the BEST/FUNKY/AWESOME/AMAZING=Pascal     
