extends Node
@onready var http_request: HTTPRequest = $HTTPRequest
@export var URL : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var headers = ["Content-Type: application/json"]
	UIControl.clear_game.connect(func():
		var data = {
			"score":UIControl.SCORE
		}
		http_request.request(URL,headers,HTTPClient.METHOD_POST,JSON.stringify(data))
		)
	

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print(result," ",response_code)
	print(body)
