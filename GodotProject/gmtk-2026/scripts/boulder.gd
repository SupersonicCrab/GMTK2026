extends Area2D

var PlayerNode : Player

func _ready() -> void:
	PlayerNode = get_tree().current_scene.get_node("Player")
	if PlayerNode:
		PlayerNode.OnPlayerTryStep.connect(OnPlayerTryStep)

@onready var Raycast = $RayCast2D

func OnPlayerTryStep():
	if PlayerNode.Raycast.is_colliding():
		if PlayerNode.Raycast.get_collider() == self:
			Raycast.target_position = PlayerNode.Raycast.target_position
			Raycast.force_raycast_update()
			
			if !Raycast.is_colliding():
				var tween = create_tween()
				tween.tween_property(self, "position",
					position + Raycast.target_position.normalized() * Constants.TileSize, 1.0/4).set_trans(Tween.TRANS_SINE)
