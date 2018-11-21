"
This extention allows to have a more readable return information
"
Class {
	#name : #FogEVMDebuggableActivation,
	#superclass : #FogEVMActivation,
	#instVars : [
		'returningType'
	],
	#category : #'FogEVM-UIDebugger-Tools'
}

{ #category : #accessing }
FogEVMDebuggableActivation >> isDebuggable [
	^ true
]

{ #category : #accessing }
FogEVMDebuggableActivation >> returnDebuggableValue [
	| value |
	returningType isEmptyType
		ifTrue: [ ^ '' ].
	value := (return isKindOf: FogEVMRegistry)
		ifTrue: [ return byteArray ]
		ifFalse: [ return ].
	value isEmptyOrNil
		ifTrue: [ ^ return ].
	^ returningType unpack: return hex using: FogHexadecimalPacker new
]

{ #category : #accessing }
FogEVMDebuggableActivation >> returningType: aType [
	returningType := aType
]
