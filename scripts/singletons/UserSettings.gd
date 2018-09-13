extends Node

#define the path of our settings file
const SETTINGS_FILE_PATH = "res://user_settings.json"

#indize all created audio busses for access in code
enum BUSIDX { MASTER, MUSIC, SOUND }

# Default Sound Configuration when the game starts
var master_volume = 0.5 setget set_master_volume
var music_volume = 0.5 setget set_music_volume
var sound_volume = 0.5 setget set_sound_volume

var master_muted = false setget set_master_muted
var music_muted = false setget set_music_muted
var sound_muted = false setget set_sound_muted

func _ready():
	#on gamestart, read settings from file
	load_settings_from_json()
	
	AudioServer.set_bus_mute(MASTER,master_muted)
	AudioServer.set_bus_mute(MUSIC,music_muted)
	AudioServer.set_bus_mute(SOUND,sound_muted)
	
	AudioServer.set_bus_volume_db(MASTER,linear2db(master_volume))
	AudioServer.set_bus_volume_db(MUSIC,linear2db(music_volume))
	AudioServer.set_bus_volume_db(SOUND,linear2db(sound_volume))


#setters and getters
func set_master_volume(value):
	master_volume = value
	AudioServer.set_bus_volume_db(MASTER,linear2db(value))

func set_master_muted(value):
	sound_muted = value
	AudioServer.set_bus_mute(MASTER,value)

func set_music_volume(value):
	music_volume = value
	AudioServer.set_bus_volume_db(MUSIC,linear2db(value))

func set_music_muted(value):
	music_muted = value
	AudioServer.set_bus_mute(MUSIC,value)

func set_sound_volume(value):
	sound_volume = value
	AudioServer.set_bus_volume_db(SOUND,linear2db(value))

func set_sound_muted(value):
	sound_muted = value
	AudioServer.set_bus_mute(SOUND,value)
	

func load_settings_from_json():
	#open the settings file
	var file = File.new()
	file.open(SETTINGS_FILE_PATH, file.READ)
	var content = file.get_as_text()
	if content == "":		
		file.close()
		print("Found empty settings file, attempting to create default one")
		save_settings_to_json()
	else:
		var settings = parse_json(content)
		#read file content to variables
		set_master_muted(settings["master_muted"])
		set_master_volume(settings["master_volume"])
		set_music_muted(settings["music_muted"])
		set_music_volume(settings["music_volume"])
		set_sound_muted(settings["sound_muted"])
		set_sound_volume(settings["sound_volume"])
		print("Loaded settings from file")
		file.close()
	
	
func save_settings_to_json():
	# Open a file
	var file = File.new()
	var settings = {
		"master_muted" : master_muted,
		"master_volume" : master_volume,
		"music_muted" : music_muted,
		"music_volume" : music_volume,
		"sound_muted" : sound_muted,
		"sound_volume" : sound_volume
		}
	var json_file = to_json(settings)
	if file.open(SETTINGS_FILE_PATH, File.WRITE) != 0:
	    print("Error saving file")
	    return
	file.store_line(json_file)
	file.close()
	print("Saved all settings to file")