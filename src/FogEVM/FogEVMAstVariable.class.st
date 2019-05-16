Class {
	#name : #FogEVMAstVariable,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'name',
		'createdAt',
		'type',
		'constant',
		'value',
		'lastValue',
		'isUseless'
	],
	#classInstVars : [
		'lastNumber'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstVariable class >> generateName [
	| gen |
	gen := 'TVar-{1}' format: {lastNumber}.
"	self haltIf: lastNumber = 77."
	lastNumber := lastNumber + 1.
	^ gen
]

{ #category : #initialization }
FogEVMAstVariable class >> initialize [
	super initialize.
	lastNumber := 0
]

{ #category : #'as yet unclassified' }
FogEVMAstVariable >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitVariable: self 
]

{ #category : #printing }
FogEVMAstVariable >> constant: aBool [
	constant := aBool
]

{ #category : #accessing }
FogEVMAstVariable >> copy [
	^ self  
]

{ #category : #accessing }
FogEVMAstVariable >> createdAt [
	^ createdAt
]

{ #category : #'as yet unclassified' }
FogEVMAstVariable >> createdAt: aFogEVMMnemonicExecutableMemoryEntry [
	createdAt := aFogEVMMnemonicExecutableMemoryEntry
]

{ #category : #accessing }
FogEVMAstVariable >> deepCopy [
	^ self  
]

{ #category : #printing }
FogEVMAstVariable >> initialize [
	super initialize.
	constant := false. 
]

{ #category : #accessing }
FogEVMAstVariable >> isAccessible [
	[ self read ]
		on: Error
		do: [ ^ false ].
	^ true
]

{ #category : #printing }
FogEVMAstVariable >> isConstant [
	^ constant
]

{ #category : #accessing }
FogEVMAstVariable >> isEVMVariable [ 
	^ true 
]

{ #category : #'as yet unclassified' }
FogEVMAstVariable >> isGenerated [
	^ name isNil or: [ name beginsWith: 'TVar']
]

{ #category : #settings }
FogEVMAstVariable >> isUseless [
	^ isUseless ifNil: [ false ].
]

{ #category : #accessing }
FogEVMAstVariable >> lastValue: aFogEVMLiteral [ 
	lastValue := aFogEVMLiteral 
]

{ #category : #marking }
FogEVMAstVariable >> markAsUseless [
	isUseless := true
]

{ #category : #accessing }
FogEVMAstVariable >> name [
	^ (name ifNil: [ name := self class generateName ]) copyReplaceAll: 'TVar' with: 'CONST'
]

{ #category : #accessing }
FogEVMAstVariable >> name: aName [
	name := aName 
]

{ #category : #printing }
FogEVMAstVariable >> printOn: aStream [
	"'	self type printOn: aStream.'"

	self isConstant
		ifTrue: [ value isEVMLiteral
				ifTrue: [ aStream nextPutAll: 'CONST('.
					value printOn: aStream.
					aStream nextPutAll: ')'.
					^ self ] ].
	aStream nextPutAll: ' '.
	aStream nextPutAll: self name
]

{ #category : #reading }
FogEVMAstVariable >> read [
	^ lastValue read
]

{ #category : #'as yet unclassified ' }
FogEVMAstVariable >> type [
	^ type ifNil: [ type := FogEVMAstUnknownType new ]
]

{ #category : #printing }
FogEVMAstVariable >> value: aValue [
	(self isConstant and: [ value isNotNil and: [ value ~= aValue ] ])
		ifTrue: [ self error: ' Constant cannot be assigned twice. ' ]
		ifFalse: [ value := aValue ]
]
