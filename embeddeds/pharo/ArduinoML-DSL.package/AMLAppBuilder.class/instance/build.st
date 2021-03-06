as yet unclassified
build
	| app |
	app := AMLApp new
		amlName: appName;
		bricks: bricks.
	states
		do: [ :eachState | 
			eachState actions
				do: [ :eachAction | eachAction actuator: (app bricks detect: [ :each | each amlName == eachAction actuator ]) ] ].
	app states: states.
	transitions isEmpty not
		ifTrue: [ 
			transitions
				do: [ :eachTransition | 
					eachTransition sensor: (app bricks detect: [ :each | each amlName == eachTransition sensor ]).
					eachTransition next: (app states detect: [ :each | each amlName == eachTransition next ]) ].
			states do: [ :eachState | eachState transition: (transitions detect: [ :each | each amlName == eachState amlName ]) ] ].
	^ app