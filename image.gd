extends Node

func _ready():
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.fractal_type = FastNoiseLite.FRACTAL_FBM
	noise.frequency = 0.1
	noise.fractal_octaves = 6

	var size = 1024

	# RGB float format (required!)
	var image = Image.create(size, size, false, Image.FORMAT_RGBF)

	for x in range(size):
		for y in range(size):
			var n = noise.get_noise_2d(x, y)

			# DO NOT normalize to 0–1
			# Convert to actual height range (meters)
			var height = n * 0.7   # adjust terrain height here

			image.set_pixel(x, y, Color(height, height, height))

	var err = image.save_exr("res://heightmap.exr", false)
	print("Save result: ", err)
