Class {
	#name : #BaselineOfUIDebugger,
	#superclass : #BaselineOf,
	#category : #BaselineOfUIDebugger
}

{ #category : #baselines }
BaselineOfUIDebugger >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec baseline: 'FogLive' with: [ spec repository: 'github://smartanvil/Fog' ].
			spec baseline: 'FogEVM' with: [ spec repository: 'github://smartanvil/FogEVM' ].
			spec baseline: 'FastTableExtentions' with: [ spec repository: 'github://sbragagnolo/FastTableExtention/src' ].
			spec baseline: 'FileDialog' with: [ spec repository: 'github://peteruhnak/file-dialog' ].
			spec package: #'FogEVM-UIDebugger' with: [ spec requires: #('FogEVM' 'FogLive' 'ParametrizedTests' 'FileDialog') ] ]
]
