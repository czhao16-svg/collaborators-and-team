extends CharacterBody2D

# -------------------------------------------------------------
# !!! IMPORTANT: CHANGE $Sprite2D TO THE ACTUAL NAME OF YOUR SPRITE NODE !!!
@onready var sprite = $Sprite2D
# -------------------------------------------------------------

# --- Movement Constants ---
# Horizontal speed for walking (pixels per second)
const SPEED = 300.0
# Vertical speed for jumping (negative means up)
var JUMP_VELOCITY = -450.0

# You can get the gravity value from Project Settings if you prefer,
# but for simplicity, we'll define a standard value here.
var gravity: float = 980.0 


func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. Handle Jump Input
	# "ui_accept" is the default action for the Space bar.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Get Horizontal Input (WASD)
	# Input.get_axis returns a value between -1 (left/A) and 1 (right/D).
	# "ui_left" corresponds to A key, "ui_right" corresponds to D key.
	var direction: float = Input.get_axis("ui_left", "ui_right")

	# 4. Calculate Horizontal Velocity AND Flip Sprite
	if direction:
		# Move the character horizontally at the defined SPEED
		velocity.x = direction * SPEED
		
		# --- Flip the sprite based on direction ---
		if direction > 0:
			# Moving right, so flip_h is false
			sprite.flip_h = false
		elif direction < 0:
			# Moving left, so flip_h is true
			sprite.flip_h = true
		# ---------------------------------------------
	else:
		# Use 'move_toward' to smoothly slow the character down when no keys are pressed.
		# This gives a nice feeling of friction.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 5. Move the Character
	# 'move_and_slide()' automatically handles collision and movement based on the 'velocity'.
	move_and_slide()
