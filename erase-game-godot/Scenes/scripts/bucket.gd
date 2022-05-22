extends Area2D

signal Crab_entered_bucket()

func _on_Bucket_body_entered(_body):
	print("Crab entered")
	$crabEnteredBucketSfx.play()
	emit_signal("Crab_entered_bucket")
	
	
