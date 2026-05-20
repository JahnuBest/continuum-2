extends Control

var chatlogs := ["", "", "", "", ""]

func _process(delta: float) -> void:
	var chatbox = $ChatList/LineEdit
	if Input.is_action_just_pressed("chat"):
		if not chatbox.has_focus(): 
			chatbox.visible = true
			chatbox.grab_focus()
			Globals.chat_open = true
		else:
			var stored_text = chatbox.text
			if stored_text != "":
				update_chat(stored_text)
			chatbox.text = ""
			chatbox.release_focus()
			Globals.chat_open = false
			chatbox.visible = false
	elif Input.is_action_just_pressed("menu") and chatbox.has_focus():
		var stored_text = chatbox.text
		chatbox.text = ""
		chatbox.release_focus()
		Globals.chat_open = false
		chatbox.visible = false
			
func update_chat(chat_msg: String) -> void:
	chatlogs.pop_front()
	chatlogs.append(chat_msg)
	if chatlogs.size() != 5: printerr("Chatlog is too big (max size: 5)")
	for i in range(5):
		# The first five children should always be the chat logs.
		$ChatList.get_child(i).text = chatlogs.get(i)
		
