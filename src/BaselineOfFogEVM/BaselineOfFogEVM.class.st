Class {
	#name : #BaselineOfFogEVM,
	#superclass : #BaselineOf,
	#category : #BaselineOfFogEVM
}

{ #category : #baselines }
BaselineOfFogEVM >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec baseline: 'TaskItShell' with: [ spec repository: 'github://sbragagnolo/taskit:dev-1.1' ].
			spec package: #Hexadecimal with: [ spec repository: 'github://sbragagnolo/Hexadecimal' ].
			spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests' ].
			spec baseline: 'Equals' with: [ spec repository: 'github://bouraqadi/PharoMisc' ].
			spec package: #FogEVM with: [ spec requires: #('TaskItShell' 'ParametrizedTests' 'Equals' 'Hexadecimal') ] ]
]
