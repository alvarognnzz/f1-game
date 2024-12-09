extends StaticBody3D

var interactions = [
	{
		"id": 0,
		"key": "E",
		"input": "interact",
		"name": "Send to race",
	}
]

func interact(_id):
	EventBus.send_to_race.emit()
