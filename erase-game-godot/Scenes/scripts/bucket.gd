extends Area2D

func _on_Bucket_body_entered(body):
	print("Crab entered")
	$crabEnteredBucketSfx.play()
	emit_signal("area_entered")
	
	
