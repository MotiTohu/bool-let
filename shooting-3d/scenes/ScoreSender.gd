extends Node

var socket = WebSocketPeer.new()

func _ready():
	socket.connect_to_url("wss://score.yosshipaopao.workers.dev/ws")
	#UIControl.failre_game.connect(func():socket.send_text("failure"))
	#UIControl.clear_game.connect(func():socket.send_text("success:"+str(UIControl.SCORE)))
	#UIControl.start_game.connect(func():socket.send_text("start"))
	await get_tree().create_timer(5)
	socket.send_text("ready")
	
func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	print(state)
	if state == WebSocketPeer.STATE_OPEN:	
		while socket.get_available_packet_count():
			print("Packet: ", socket.get_packet())
	elif state == WebSocketPeer.STATE_CLOSING:
		# Keep polling to achieve proper close.
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		socket.connect_to_url("wss://score.yosshipaopao.workers.dev/ws")
		
