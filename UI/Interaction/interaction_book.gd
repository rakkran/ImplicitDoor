extends RichTextLabel
class_name BookInteraction

var book_text : Array[String] = []
var page_num : int = 0
var page_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "" # Replace with function body.

func set_book_text(display_text : Array[String]):
	book_text = display_text.duplicate()
	text = book_text[0]
	page_num = book_text.size()

func exit_book():
	text = ""
	page_index = 0
	book_text.clear()

func next_page():
	if page_index >= page_num - 1:
		GameUi.exit_book_text()
	else:
		page_index += 1
		text = book_text[page_index]

func prev_page():
	if page_index <= 0:
		return
	else:
		page_index -= 1
		text = book_text[page_index]
