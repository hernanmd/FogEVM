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
			spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests' ].
			spec package: #FogEVM with: [ spec requires: #('ParametrizedTests') ] ]
]
