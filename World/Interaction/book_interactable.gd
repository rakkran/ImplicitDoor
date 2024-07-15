extends Interactable
class_name BookInteractable

@export var prompt_text : String = "The Book of Rak"
var is_reading : bool = false
var book_text : Array[String] = ["Once upon a time, there was a man named steve. He was pretty cool, I guess.",
"He died though. RIP", "This is the last page. Yahoo!"]

func _on_focused(_interactor):
	if not GameUi.interact_book_state:
		GameUi.set_prompt(prompt_text)

func _on_interacted(_interactor):
	GameUi.remove_prompt()
	GameUi.set_book_text(book_text)

func _on_unfocused(_interactor):
	GameUi.remove_prompt()
