extends CanvasLayer

@onready var label:Label = get_node("Box_Dialogue/Label")
@onready var icon:TextureRect = get_node("Box_Image/Icon")

var place:String

var msg_queue:Array = []
var icons:Array = []

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		display_text()

func display_text()->void:
	if msg_queue.size() == 0:
		Main.in_scene = false
		Main.finish_dialogue()
		if Main.can_change_scene and !Main.in_scene:
			Main.change_scene(place)
		else:
			visible = false
		return
	var msg:String = msg_queue.pop_front()
	var icon_path:String = icons.pop_front()
	var tween_label:Tween = create_tween()
	tween_label.tween_property(label,"text",msg,0.9).from("")
	icon.texture = ResourceLoader.load(icon_path)
