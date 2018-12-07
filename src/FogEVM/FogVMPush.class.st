"
Place N bytes item on stack
"
Class {
	#name : #FogVMPush,
	#superclass : #FogEVMInstruction,
	#traits : 'TEquality',
	#classTraits : 'TEquality classTrait',
	#instVars : [
		'bytes',
		'parameter'
	],
	#category : 'FogEVM-ByteCode'
}

{ #category : #'accessing method dictionary' }
FogVMPush class >> addAndClassifySelector: selector withMethod: compiledMethod inProtocol: aCategory [
<doc>
	
	"When a new methods is added, I add it to the localMethodDict and also propagate the changes to my users"
	self localMethodDict at: selector put: compiledMethod.
	
	super
		addAndClassifySelector: selector
		withMethod: compiledMethod
		inProtocol: aCategory.

	TraitChange addSelector: selector on: self.	
]

{ #category : #'accessing method dictionary' }
FogVMPush class >> addSelector: selector withMethod: compiledMethod [
<doc>
	"When a new selector is installed in a class I insert the selector in the local methodDict and propagate the changes to my users"
	
	self localMethodDict at: selector put: compiledMethod.
	super addSelector: selector withMethod: compiledMethod.
	TraitChange addSelector: selector on: self
]

{ #category : #'accessing method dictionary' }
FogVMPush class >> addSelector: selector withMethod: compiledMethod notifying: requestor [
<doc>
	self
		deprecated: 'Please use #addSelector:withMethod: instead'
		transformWith:
			'`@receiver addSelector: `@statements1 withMethod: `@statements2 notifying: `@statements3'
		   -> '`@receiver addSelector: `@statements1 withMethod: `@statements2'.
	^self addSelector: selector withMethod: compiledMethod
]

{ #category : #querying }
FogVMPush class >> allTraits [
<doc>
	^ self traitComposition allTraits
]

{ #category : #'as yet unclassified' }
FogVMPush class >> byteCode [
<doc>
	^ 'no-meaning'
]

{ #category : #'as yet unclassified' }
FogVMPush class >> description [ 
<doc>
	^ 'Place N bytes item on stack'
]

{ #category : #initialization }
FogVMPush class >> doRebuildMethodDictionary [
<doc>
	| selectors removedSelectors removeFromOrganization modified|

	"During the creation of the class or after a change in the traitComposition, the whole method dictionary is calculated.
	If I return true, my users should be updated"

	"1. I recreate the local methodDict"
	modified := false.
	self methodDict valuesDo: [ :m | m traitSource ifNil: [ self localMethodDict at: m selector put: m ]].

	"2. I filter the selectors from the trait composition, rejecting the ones that are locally defined.
	And then I install the methods in myself. The trait composition only install the method if it is needed."
	selectors := self traitComposition selectors reject: [ :e | (self localMethodDict includesKey: e) ].
	selectors do: [ :e | modified := modified | (self traitComposition installSelector: e into: self replacing: false)].

	"3. I handle the methods that I have and they are no more in the traitComposition."
	removedSelectors := self methodDict keys reject: [ :aSelector | (selectors includes: aSelector) or: [ self localMethodDict includesKey: aSelector] ].
	modified := modified | (removedSelectors isNotEmpty).
	removedSelectors do: [ :aSelector | self methodDict removeKey: aSelector ].

	"4. Finally, I remove these methods from my class organization"
	removeFromOrganization := self organization allMethodSelectors reject: [:e | self methodDict includesKey: e ].
	removeFromOrganization do: [ :aSelector | self organization removeElement: aSelector ].

	^ modified
]

{ #category : #generated }
FogVMPush class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMPush class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #generated }
FogVMPush class >> fetchGoCode [
<doc>
	| stream lowcaseStream selector bytes goCode |
	stream := 'instructions.go' asFileReference readStream.
	lowcaseStream := stream contents asLowercase readStream.
	selector := 'func makePush' asLowercase.
	lowcaseStream upToAll: selector.
	stream position: lowcaseStream position - selector size.
	bytes := (lowcaseStream upToAll: 'func') size + (lowcaseStream upToAll: 'func') size + (lowcaseStream upToAll: 'func') size.
	goCode := stream next: bytes.
	self class
		compile:
			('goCode
	^ ''{1}''' format: {goCode})
		classified: #generated
]

{ #category : #testing }
FogVMPush class >> findOriginClassOf: aMethod [
<doc>

	"I return the myself or the trait that has the original implementation of a method.
	If the method is an alias, the returned class includes the original aliased method"

	(aMethod hasProperty: #traitSource) 
		ifTrue: [ ^ aMethod traitSource innerClass ]. 

	(self includesLocalSelector: aMethod selector)
		ifTrue: [ ^ self ].

	^ (self traitComposition traitDefining: aMethod selector ifNone: [ ^ self ]) innerClass
]

{ #category : #testing }
FogVMPush class >> findOriginMethodOf: aMethod [
<doc>

	"I return the original method for a aMethod.
	If this is a local method, the original method is itself.
	If it cames from a trait composition I look for the method in the trait composition.
	First I try with the trait stored in the traitSource. 
	If it is an aliased or conflicting method, the method is look up in the whole trait composition"

	(self includesLocalSelector: aMethod selector)
		ifTrue: [ ^ aMethod ].

	(aMethod hasProperty: #traitSource)
		ifTrue: [ |newSelector|
			newSelector := self traitComposition originSelectorOf: aMethod selector.
			^ aMethod traitSource compiledMethodAt: newSelector ifAbsent: [aMethod] ].

	^ (self traitComposition traitDefining: aMethod selector ifNone: [ self ])
		compiledMethodAt: aMethod selector ifAbsent: [ ^ aMethod ]		
]

{ #category : #generated }
FogVMPush class >> goCode [
<doc>
	^ 'func makePush(size uint64, pushByteSize int) executionFunc {
	return func(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
		codeLen := len(contract.Code)

		startMin := codeLen
		if int(*pc+1) < startMin {
			startMin = int(*pc + 1)
		}

		endMin := codeLen
		if startMin+pushByteSize < endMin {
			endMin = startMin + pushByteSize
		}

		integer := interpreter.intPool.get()
		stack.push(integer.SetBytes(common.RightPadBytes(contract.Code[startMin:endMin], pushByteSize)))

		*pc += size
		return nil, nil
	}
}

// '
]

{ #category : #testing }
FogVMPush class >> hasTraitComposition [
<doc>
	
	^ self traitComposition isEmpty not
]

{ #category : #testing }
FogVMPush class >> includesLocalSelector: aSymbol [
<doc>
	^ self isLocalSelector: aSymbol
]

{ #category : #generated }
FogVMPush class >> instance [
<doc>
	^ self new
]

{ #category : #'as yet unclassified' }
FogVMPush class >> instance0x00 [
<doc>
	^ self new parameter: '0x00'; yourself 
]

{ #category : #'as yet unclassified' }
FogVMPush class >> instance0x0002 [
<doc>
	^ self new
		parameter: '0x0002';
		yourself
]

{ #category : #testing }
FogVMPush class >> isAliasSelector: aSymbol [
<doc>
	"Return true if the selector aSymbol is an alias defined
	in my or in another composition somewhere deeper in 
	the tree of traits compositions."

	^ self traitComposition isAliasSelector: aSymbol
]

{ #category : #testing }
FogVMPush class >> isLocalAliasSelector: aSymbol [
<doc>
	"Return true if the selector aSymbol is an alias defined
	in my trait composition."

	^ self traitComposition isLocalAliasSelector: aSymbol
]

{ #category : #testing }
FogVMPush class >> isLocalMethodsProtocol: aProtocol [
<doc>

	"Checks if the protocol has local selectors"
	aProtocol methods ifEmpty: [ ^true ].
	^aProtocol methods anySatisfy: [ :each | self isLocalSelector: each]
]

{ #category : #testing }
FogVMPush class >> isLocalSelector: aSelector [
<doc>
	
	^ self localMethodDict includesKey: aSelector
]

{ #category : #accessing }
FogVMPush class >> localMethodDict [
<doc>
	"The local methodDict is in the metaclass. In this way I do not have to recompile the methods during the bootstrap when we don't have a compiler."
	^ self class baseLocalMethods
]

{ #category : #accessing }
FogVMPush class >> localMethodDict: aMethodDictionary [
<doc>
	^ self class baseLocalMethods: aMethodDictionary 
]

{ #category : #accessing }
FogVMPush class >> localMethods [
<doc>
	"returns the methods of classes excluding the ones of the traits that the class uses" 
	 
	^ self localMethodDict values
]

{ #category : #'accessing method dictionary' }
FogVMPush class >> localSelectors [
<doc>
	
	^ self localMethodDict keys
]

{ #category : #initialization }
FogVMPush class >> rebuildMethodDictionary [
<doc>

	"Useful to be rewritten in Traits"
	^ self doRebuildMethodDictionary.
]

{ #category : #categories }
FogVMPush class >> recategorizeSelector: selector from: oldCategory to: newCategory [
<doc>
	| original |
	
	"When a method is recategorized I have to classify the method, but also recategorize the aliases pointing to it"
	
	original := self organization categoryOfElement: selector ifAbsent: [ ^ self ].

	"If it is nil is because it is a removal. It will removed when the method is removed."
	newCategory ifNil: [ ^ self ].

	original = oldCategory
		ifTrue: [ self organization classify: selector under: newCategory suppressIfDefault: true ].

	(self traitComposition reverseAlias: selector) do: [ :e | 
		self recategorizeSelector: e from: oldCategory to: newCategory. 
		self notifyOfRecategorizedSelector: e from: oldCategory to: newCategory ].
	
	self organization removeEmptyCategories
]

{ #category : #'trait-composition' }
FogVMPush class >> removeFromComposition: aTrait [
<doc>

	self setTraitComposition: (self traitComposition copyWithoutTrait: aTrait asTraitComposition)
]

{ #category : #removing }
FogVMPush class >> removeFromSystem: logged [
<doc>
	
	"When a traited class is removed the traits it is using should be updated"
	| mySubclasses |
	self traitComposition removeUser: self.
	self class traitComposition removeUser: self class.

	TraitedClass removeUser: self class.
	
	mySubclasses := self subclasses.
	
	super removeFromSystem: logged.
	
	"As I am a traited class my subclasses does not have the basic traited class 
	methods, so I add them."
	mySubclasses do: [ :each | each class initializeBasicMethods ].
]

{ #category : #removing }
FogVMPush class >> removeSelector: aSelector [
<doc>

	"When a selector is removed it should be notified to my users.
	Check the class TraitChange for more details"
	super removeSelector: aSelector.
	self localMethodDict removeKey: aSelector ifAbsent: [  ].

	TraitChange removeSelector: aSelector on: self.
]

{ #category : #'accessing tags' }
FogVMPush class >> tagsForMethods [
<doc>
	"Any method could be tagged with multiple symbols for user purpose. 
	And class contains all method tags which used or not used yet by methods.
	For now we could only implemented it on top of Protocol. 
	It supposed to not include any method tags inherited from Traits 
	which is opposite to current Protocol implementation.
	And extension protocol is not treated as tag"
	| allProtocols |
	allProtocols := self organization protocols reject: [ :each | each name = Protocol unclassified | each isExtensionProtocol ].
		
	^ allProtocols select: [ :each | self isLocalMethodsProtocol: each ] thenCollect: #name
]

{ #category : #accessing }
FogVMPush class >> traitComposition [
<doc>
	"My trait composition is in my class. So I do not need to recompile the methods when installing them during bootstrap"
	^ self class baseComposition
]

{ #category : #accessing }
FogVMPush class >> traitComposition: anObject [
<doc>
	
	self class baseComposition: anObject
]

{ #category : #accessing }
FogVMPush class >> traitCompositionString [
<doc>
	^ self traitComposition asString
]

{ #category : #accessing }
FogVMPush class >> traitUsers [
<doc>
	"I am a traited class, I have no users, this is for compatibility with traits"
	^ #()
]

{ #category : #accessing }
FogVMPush class >> traits [
<doc>
	^ self traitComposition traits.
]

{ #category : #converting }
FogVMPush >> asPushableRegistry [
	^ FogEVMRegistry forPush: self 
]

{ #category : #accessing }
FogVMPush >> bytes [
	^ bytes
]

{ #category : #testing }
FogVMPush >> isPush [
	^ true
]

{ #category : #'as yet unclassified' }
FogVMPush >> loadParametersFrom: anHexaStream [
	parameter := '0x' , (anHexaStream next: bytes * 2)
]

{ #category : #'as yet unclassified' }
FogVMPush >> parameter [
	^ parameter
]

{ #category : #'as yet unclassified' }
FogVMPush >> parameter: aString [ 
	parameter := aString
]

{ #category : #printing }
FogVMPush >> printBinaryOn: aStream [
	| stream |
	super printBinaryOn: aStream.
	aStream nextPutAll: self asPushableRegistry asRegistryLengthArray .
	
]

{ #category : #printing }
FogVMPush >> printHexaOn: aStream [
	super printHexaOn: aStream.
	aStream nextPutAll: self asPushableRegistry asWordByteArray hex
]

{ #category : #printing }
FogVMPush >> printOn: aStream [
	aStream
		nextPutAll: self mnemonic;
		nextPutAll: ' ';
		nextPutAll: self asPushableRegistry printString
]

{ #category : #'as yet unclassified' }
FogVMPush >> pushable [
	^ parameter 
]

{ #category : #'as yet unclassified' }
FogVMPush >> size [
	^ super size + bytes
]
