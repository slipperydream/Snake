extends Node

@export var grid : Resource = null
@export var snake_scene : PackedScene

var score : int
var game_started : bool = false
signal reset_game

# snake variables
var old_data : Array
var snake_data : Array
var snake : Array

# movement variables
@export var start_pos = Vector2(9,9)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var move_direction : Vector2
var can_move : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_snake()

func new_game():
	emit_signal("reset_game")
	move_direction = up
	can_move = true
	generate_snake()

func generate_snake():
	old_data.clear()
	snake_data.clear()
	snake.clear()	
	
	# starting at the start_pos draw 3 snake segments
	for i in range(3):
		add_segment(start_pos + Vector2(0, i))

func add_segment(pos):
	snake_data.append(pos)
	var SnakeSegment = snake_scene.instantiate()
	SnakeSegment.position = (pos * grid.cell_size) + Vector2(0, grid.cell_size)
	add_child(SnakeSegment)
	snake.append(SnakeSegment)

func move_snake():
	if can_move:
		if Input.is_action_just_pressed("move_down") and move_direction != up:
			move_direction = down
			can_move = false
			if game_started == false:
				start_game()
		if Input.is_action_just_pressed("move_up") and move_direction != down:
			move_direction = up
			can_move = false
			if game_started == false:
				start_game()
		if Input.is_action_just_pressed("move_left") and move_direction != right:
			move_direction = left
			can_move = false
			if game_started == false:
				start_game()
		if Input.is_action_just_pressed("move_right") and move_direction != left:
			move_direction = right
			can_move = false
			if game_started == false:
				start_game()
				
func start_game():
	game_started = true
	$MoveTimer.start()

func _on_move_timer_timeout():
	# allow snake movement
	can_move = true
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		# move the other segments one by one
		if i > 0:
			snake_data[i] = old_data[i - 1]
		snake[i].position = (snake_data[i] * grid.cell_size) + Vector2(0, grid.cell_size)
		
