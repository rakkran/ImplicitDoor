## Displays text 
extends RichTextLabel
class_name InteractionText

var display_text : Array[String] = []
var char_index : int = 0
var page_index : int = 0
var page_num : int = 0

const SCROLL_SPEED : float = 1.0

func _ready():
	text = "" 
	visible_ratio = 0.0

func set_display_text(new_text : Array[String]):
	if display_text.is_empty():
		display_text = new_text
		text = display_text[0]
		page_num = display_text.size()

func exit_interact():
	display_text.clear()
	char_index = 0
	page_index = 0
	visible_ratio = 0.0
	text = ""
	
func _process(delta):
	if not display_text.is_empty():
		visible_ratio = clamp(visible_ratio + (SCROLL_SPEED/text.length()) , 0.0, 1.0)

func goto_next_page():
	page_index += 1
	if page_index >= page_num:
		GameUi.exit_interaction_text.emit()
	else:
		text = display_text[page_index]
		char_index = 0
		visible_ratio = 0.0

func skip_text():
	if visible_ratio >= 1.0:
		goto_next_page()
	elif visible_ratio > 0.05:
		visible_ratio = 1.0
