extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var msec: int = 0
var mainText = ""

func _process(delta):
	time += delta
	msec = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d." % seconds
	$Miliseconds.text = "%03d" % msec
	mainText = Global.school + " semifinals"
	$MainText.text = mainText
	if(Global.school.length() > 0):
		$MainText.add_color_override("font_color", Color(Global.schools_colors[Global.school]))
