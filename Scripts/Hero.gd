extends KinematicBody2D

# Valor inicial da Lifebar
var life = 100;

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -650

var motion = Vector2()

func _ready():
	# Esconde o texto da barra
	$Lifebar.percent_visible=false

	$Sprite.flip_h = false

func _physics_process(delta):	
	# Mantem a barra atualizada
	$Lifebar.value = life
	
	motion.y += GRAVITY

	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		$Sprite.play('walk')
		motion.x = -SPEED
	elif  Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		$Sprite.play('walk')
		motion.x = SPEED
	else:
		$Sprite.play('idle')
		motion.x = 0

	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play('jump')

	motion = move_and_slide(motion, UP)

func die():
	self.alive=false

func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "die":
		self.queue_free()
