extends Node2D

@onready var cat_image: TextureRect = $TextureRect
@onready var http_cat: HTTPRequest = $HTTPRequest
@onready var panel: Panel = $Panel

var car_url = "https://cataas.com/cat"

func _ready() -> void:
	http_cat.request_completed.connect(image_loaded)
	http_cat.request(car_url)
	panel.size = cat_image.size + Vector2(10, 10)
	panel.position = cat_image.position - Vector2(5, 5)
	panel.pivot_offset = cat_image.size / 2

func image_loaded(result, response_code, headers, body):
	var image = Image.new()
	var error = image.load_jpg_from_buffer(body)
	cat_image.texture = ImageTexture.create_from_image(image)
	
	if error != OK:
		http_cat.request(car_url)
		return


func _on_restart_cat_pressed() -> void:
	http_cat.request_completed.connect(image_loaded)
	http_cat.request(car_url)
