extends Node

func _on_SettingsButton_pressed():
	$GUI/SettingsWindow.popup()

func _on_PlaySoundButton_pressed():
	$Audio/DemoSoundPlayer.play()