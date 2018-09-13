extends Control

#Here we connect the button signals.
#The sound settings are changed in res://scripts/gui/SettingsWindow.gd



func _on_SettingsButton_pressed():
	$SettingsWindow.popup()

func _on_Button_pressed():
	$Button/DemoSoundPlayer.play()

func _on_StartButton_pressed():
	get_tree().change_scene_to(load("res://scenes/Game.tscn"))

func _on_QuitButton_pressed():
	get_tree().quit()
