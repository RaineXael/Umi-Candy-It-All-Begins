extends CanvasLayer

@export var party_leader = "Umi"

@onready var leader_label = $RibbonSide/Label

func _ready() -> void:
	leader_label.text = party_leader


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
