extends AbstractState

onready var jump_sfx: AudioHandler = $JumpSFX
onready var land_sfx: AudioHandler = $"%LandSFX"
onready var hit_sfx: AudioHandler = $"%HitSFX"
onready var jump_particles: Particles2D = $"%JumpParticles"
onready var doble_jump_sfx: AudioHandler = $DobleJumpSFX
var ghost_scene = preload("res://src/game/entities/player/JumpGhost.tscn")
export (int) var jumps_limit:int = 1
onready var player = $"../.."
onready var ghost_timer = $GhostTimer
onready var doble_jump_particles = $"../../BodyPivot/DobleJumpParticles"
onready var doble_jump_burst = $"../../BodyPivot/DobleJumpBurst"

var jumps:int = 0
onready var body = $"%Body"



func enter() -> void:
	character.snap_vector = Vector2.ZERO
	character.velocity.y = -character.jump_speed
	character._play_animation("jump")
	jump_sfx.play()
	jump_particles.emitting = true


func exit() -> void:
	jumps = 0


func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("dash") && character.move_direction != 0:
		emit_signal("finished", "dash")
	elif event.is_action_pressed("jump") && jumps < jumps_limit:
		jumps += 1
		character.velocity.y = -character.jump_speed
		character._play_animation("jump")
		doble_jump_sfx.play()
		doble_jump_particles.restart()
		doble_jump_particles.emitting = true
		ghost_timer.start()
		instance_ghost()
		doble_jump_burst.restart()
		doble_jump_burst.emitting = true

func instance_ghost():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().get_parent().get_parent().add_child(ghost)
	ghost.global_position = body.global_position
	ghost.texture = body.texture
	ghost.vframes = body.vframes
	ghost.hframes = body.hframes
	ghost.frame = body.frame
	if character.move_direction == -1:
		ghost.flip_h = true
	
	
	
	


func update(delta: float) -> void:
	character._handle_weapon_actions(delta)
	character._handle_move_input()
	if character.move_direction == 0:
		character._handle_deacceleration(delta)
	character._apply_movement()
	if character.is_on_floor():
		if character.move_direction == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "walk")
		land_sfx.play()
	else:
		if character.velocity.y > 0:
			character._play_animation("fall")
			if ghost_timer != null:
				ghost_timer.stop()
		else:
			character._play_animation("jump")


func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			hit_sfx.play()
			character.sum_hp(value)
		"healed":
			character.sum_hp(value)
		"hp_changed":
			if value[0] == 0:
				emit_signal("finished", "dead")


func _on_GhostTimer_timeout():
	instance_ghost()
