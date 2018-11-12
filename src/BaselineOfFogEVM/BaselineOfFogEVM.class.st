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
			spec baseline: 'FogDB' with: [ spec repository: 'github://smartanvil/fog' ].
			spec baseline: 'FastTableExtentions' with: [ spec repository: 'github://sbragagnolo/FastTableExtention/src' ].
			spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests' ].
			spec baseline: 'FileDialog' with: [ spec repository: 'github://peteruhnak/file-dialog' ].
			spec package: #FogEVM with: [ spec requires: #('FogDB' 'FastTableExtentions' 'ParametrizedTests' 'FileDialog') ] ]
]
