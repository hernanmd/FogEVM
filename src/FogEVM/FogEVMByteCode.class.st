"
ByteCode is wrappes an ordered collection of bytecode. 

Besides collecting the bytecode in the program's order, and providing some basic collections features, such as #at:, #at:put:,  it also provides some bytecode as program methods as, toBinary, toHexa. It allows the usage of visitors by implementing #accept: and, last but not least, it provides readStream and writeStream based on bytecode streams. 
"
Class {
	#name : #FogEVMByteCode,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'FogEVM-ByteCode'
}

{ #category : #'instance creation' }
FogEVMByteCode class >> fromBinary: anHexaContent [
	| stream result |
	stream := (anHexaContent copyReplaceAll: '0x' with: '') readStream.
	result := OrderedCollection new.
	[ stream atEnd ]
		whileFalse: [ | instruction byteLocation |
			byteLocation := stream position / 2.
			instruction := self instructionFor: (stream next: 2).
			instruction loadParametersFrom: stream.
			result
				add:
					(FogEVMMnemonicExecutableMemoryEntry new
						byteNumber: byteLocation;
						instruction: instruction) ].
	^ self new
		content: result;
		yourself
]

{ #category : #private }
FogEVMByteCode class >> instructionFor: aCode [
	| code |
	code := '0x' , aCode.
	^ (FogEVMInstruction allSubclasses
		detect: [ :c | c byteCode = code ]
		ifNone: [ FogEVMUnknown new
				byteCode: code;
				yourself ]) instance
]

{ #category : #converting }
FogEVMByteCode >> accept: anInterpreter [
	^ content do: [ :e | e accept: anInterpreter with: content ]
]

{ #category : #collection }
FogEVMByteCode >> at: anIdx [
	<doc: 'returns the bytecode located at the given index'>
	^ content at: anIdx
]

{ #category : #collection }
FogEVMByteCode >> at: anIdx put: aValue [
<doc: 'puts the given bytecode at the given index'>
	content at: anIdx put: aValue
]

{ #category : #'as yet unclassified' }
FogEVMByteCode >> bytecodeSize [
	^ (content reject: #isNil thenCollect: [ :c | c instruction size ]) sum
]

{ #category : #accessing }
FogEVMByteCode >> content [
	<doc: 'returns the content wrapped by this collection.'>
	^ content 
]

{ #category : #accessing }
FogEVMByteCode >> content: aCollection [
	content := aCollection
]

{ #category : #collection }
FogEVMByteCode >> grownBy: anInteger [
	content := content grownBy: anInteger.
	^ self
]

{ #category : #converting }
FogEVMByteCode >> hasConstructor [
	| copyCodes shouldByPush10x0 shouldBeReturn |
	copyCodes := content select: [ :i | i instruction isCopyCode ].
	copyCodes isEmpty
		ifTrue: [ ^ false ].
	self assert: copyCodes size = 1.
	shouldByPush10x0 := (content indexOf: (copyCodes at: 1)) + 1.
	shouldBeReturn := shouldByPush10x0 + 1.
	^ (content at: shouldByPush10x0) instruction = FogVMPush1 instance0x00
		and: [ (content at: shouldBeReturn) instruction = FogVMReturn instance ]
]

{ #category : #initialization }
FogEVMByteCode >> initialize [
	super initialize.
	content := OrderedCollection new
]

{ #category : #converting }
FogEVMByteCode >> isBinary [ 
	^ self hasConstructor 
]

{ #category : #converting }
FogEVMByteCode >> isNotEmpty [
	^ content isNotEmpty 
]

{ #category : #converting }
FogEVMByteCode >> isRuntime [
	^ self hasConstructor not
]

{ #category : #converting }
FogEVMByteCode >> printOn: aStream [
	aStream nextPutAll: 'ByteCode- '.
	content printOn: aStream
]

{ #category : #converting }
FogEVMByteCode >> readStream [
	<doc: 'Returns a FogEVMByteCodeReadStream stream over this bytecode.'>
	^ FogEVMByteCodeReadStream on: content
]

{ #category : #accessing }
FogEVMByteCode >> sequence [
	^ self content
]

{ #category : #converting }
FogEVMByteCode >> size [
	<doc: 'returns the bytecode size'>
	^ content size 
]

{ #category : #converting }
FogEVMByteCode >> toBinary [
	<doc: 'Returns the bytecode into a it''s binary representation'>
	^ ((content reject: #isNil thenCollect: #instruction)
		inject: OrderedCollection new writeStream
		into: [ :acc :each | 
			each printBinaryOn: acc.
			acc ]) contents asByteArray
]

{ #category : #converting }
FogEVMByteCode >> toHexa [
	<doc: 'Returns the bytecode into a it''s hexadecimal representation'>
	^ ((content reject: #isNil thenCollect: #instruction)
		inject: '' writeStream
		into: [ :acc :each | 
			each printHexaOn: acc.
			acc ]) contents
]

{ #category : #'debugger ui' }
FogEVMByteCode >> values [
	^ {}
]

{ #category : #converting }
FogEVMByteCode >> writeStream [
	<doc: 'Returns a FogEVMByteCodeWriteStream stream over this bytecode.'>
	^ FogEVMByteCodeWriteStream on: self
]
