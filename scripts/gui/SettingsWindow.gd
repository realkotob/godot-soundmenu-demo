extends WindowDialog

#Attach this Window to your game scene with a way to show it 
#as seen in res://scenes/Game.tscn

#In this demo, I use SliderButton to let the user control the volume
#of two AudioBusses I created: "music" and "sfx"

#It is important to assign every AudioStreamPlayer to one of these busses
#in order to control their volume.

#If a slider or checkbox value changes, it emits a signal
#and the new value is passed to the UserSettings singleton
#(res://scripts/singletons/UserSettings.gd)


#Store interactive nodes for easy access
onready var master_slider = $MarginContainer/VBoxContainer/MasterContainer/MasterSlider
onready var music_slider = $MarginContainer/VBoxContainer/MusicContainer/MusicSlider
onready var sound_slider = $MarginContainer/VBoxContainer/SoundContainer/SoundSlider

onready var muaster_checkbox = $MarginContainer/VBoxContainer/MasterContainer/MasterCheck
onready var music_checkbox = $MarginContainer/VBoxContainer/MusicContainer/MusicCheck
onready var sound_checkbox = $MarginContainer/VBoxContainer/SoundContainer/SoundCheck

#load values from UserSettings to display them
func _on_SettingsWindow_about_to_show():
	master_slider.value = UserSettings.master_volume
	muaster_checkbox.pressed = UserSettings.master_muted
	music_slider.value = UserSettings.music_volume
	music_checkbox.pressed = UserSettings.music_muted
	sound_slider.value = UserSettings.sound_volume
	sound_checkbox.pressed = UserSettings.sound_muted

#when the menu is closed, tell UserSettings singleton to store current settings in a file
func _on_SettingsWindow_popup_hide():
	UserSettings.save_settings_to_json()
	
#pass changes to UserSettings on signal
func _on_MasterSlider_value_changed(value):
	UserSettings.master_volume = value

func _on_MusicSlider_value_changed(value):
	UserSettings.music_volume = value

func _on_SoundSlider_value_changed(value):
	UserSettings.sound_volume = value
	
func _on_MasterCheck_toggled(button_pressed):
	UserSettings.master_muted = button_pressed	

func _on_MusicCheck_toggled(button_pressed):
	UserSettings.music_muted = button_pressed

func _on_SoundCheck_toggled(button_pressed):
	UserSettings.sound_muted = button_pressed
	
func _on_BackButton_pressed():
	hide()

