extends Label

var facts: = {
	"fact_1": "Hummingbirds have a ball-socket joint in in their shoulder that lets them rotate their wings to hover, fly backwards or even upside down!",
	"fact_2": "Hummingbirds need to consume nearly half their body weight in sugar each day or risk exhaustion.",
	"fact_3": "The iridescent colour of hummingbirds comes from the reflective properties of their feather, not from any pigments!",
	"fact_4": "When a Hummingbird is low on energy, it can enter a torpor to conserve energy and survive until sugars are available again.",
	"fact_5": "Hummingbirds have huge brains for their size! This helps them remeber where the best sources of food are, and give them the reflexes to react quickly as they fly!",
	"fact_6": "Some hummingbirds migrate over vast distances with the changing seasons to find new sources of sugar."  
}

func _ready():
	push_random()

func push_random():
	text = facts.values().pick_random()
