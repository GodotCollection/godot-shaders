extends Node2D

const EXCLUSIONS := [
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 20, 21, 22, 
	23, 24, 25, 26, 27, 28, 29, 30, 31, 43, 44, 45, 
	46, 47, 48, 49, 50, 51, 52, 66, 67, 68, 
	69, 70, 71, 72, 73, 89, 90, 91, 
	92, 93, 94, 113, 114, 
	115, 136, 137, 
	159, 160, 
	182, 183, 
	184, 206, 
	207, 229, 
	230, 231, 252, 
	253, 254, 275, 
	276, 277, 278, 
	299, 300, 301, 321, 
	322, 323, 324, 325, 343, 344, 
	345, 346, 347, 348, 365, 366, 367, 
	368, 369, 370, 371, 372, 387, 388, 389, 390, 
	391, 392, 393, 394, 395, 396, 409, 410, 411, 412, 413, 
	414, 415, 416, 417, 418, 419, 420, 421, 431, 432, 433, 434, 435, 436, 
	437, 438, 439, 440, 441, 442, 443, 444, 445, 453, 454, 455, 456, 457, 458, 459, 
	460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 475, 476, 477, 478, 479, 480, 481, 482
]

export var Pixel: PackedScene
export var top_left := Vector2(758.377, 320.169)
export var width := 0
export var height := 0
export var pixel_size := 19.18


func _ready() -> void:
	for y in range(height):
		for x in range(width):
			if (y * width + x) in EXCLUSIONS:
				continue
			var pixel := Pixel.instance()
			pixel.position = top_left + Vector2(x * pixel_size, y * pixel_size)
			pixel.size = Vector2(pixel_size, pixel_size)
			add_child(pixel)


func do_render() -> void:
	var delay := 0.0
	for i in range(0, get_child_count(), 8):
		for j in range(8):
			if j+i < get_child_count():
				var child := get_child(j + i)
				child.do_scale_down(delay)
		delay += 0.15
	yield(get_tree().create_timer(delay), "timeout")
