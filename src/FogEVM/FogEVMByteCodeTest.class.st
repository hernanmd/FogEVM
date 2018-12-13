"
Test case based on the compiled version of the contract

 pragma solidity ^0.4.8;

contract Public3StatesPoll {

   /* Type Definition */
    enum Choice { POSITIVE , NEGATIVE , NEUTRAL }
    struct Columns {  address user; Choice choice ; bool hasVoted; }

   /* Properties */
    Columns[] pollTable; 
    address owner;
    
     /* Constructor */
    function Public3StatesPoll () { 
        owner = msg.sender;
    }
    /* Functions */ 
    function isRegistered (address voterAccount) returns(bool registered){
        registered = (voterIndex (voterAccount) >= 0);
    }
    function voterIndex (address voterAccount) returns(int256 index){
        for(uint x = 0; x < pollTable.length; x = x +1) {
            if (pollTable[x].user == voterAccount) {
                return int(x);
            }
        }
        return -1;
    }
    function addVoter(address voterAccount) returns(uint256){
        if(owner != msg.sender) throw; 
        if(isRegistered(voterAccount)) throw; 
        pollTable.push(Columns(voterAccount, Choice.NEUTRAL, false));
        return pollTable.length -1;
    }
    function vote (Choice choice) {
        uint index;
	uint sarasa =2;

        if (!isRegistered(msg.sender)) throw; 
        index = uint(voterIndex(msg.sender));
        pollTable[index].choice = choice;
    }
    function votesFor(Choice choice) {
       uint votes = 0;
       for(uint x = 0; x < pollTable.length; x = x +1) {
            if (pollTable[x].hasVoted && pollTable[x].choice == choice) 
                votes = votes +1;
        }
    }
    function allParticipantsHaveVoted () view returns (bool) {
	for(uint x = 0; x < pollTable.length; x = x +1) {
            if (!pollTable[x].hasVoted) return false;
        }
	return true;
    }
}

"
Class {
	#name : #FogEVMByteCodeTest,
	#superclass : #TestCase,
	#instVars : [
		'contractDescription',
		'binary',
		'runtime'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #'as yet unclassified' }
FogEVMByteCodeTest >> binary [
	^ FogEVMByteCode
		fromBinary:
			'0x608060405234801561001057600080fd5b5033600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550610608806100616000396000f300608060405260043610610078576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063067e050f1461007d578063b3f98adc146100ad578063c3c5a547146100dd578063c88b2aac14610138578063cea6cf5e1461018f578063f4ab9adf146101be575b600080fd5b34801561008957600080fd5b506100ab600480360381019080803560ff169060200190929190505050610215565b005b3480156100b957600080fd5b506100db600480360381019080803560ff1690602001909291905050506102be565b005b3480156100e957600080fd5b5061011e600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610326565b604051808215151515815260200191505060405180910390f35b34801561014457600080fd5b50610179600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919050505061033b565b6040518082815260200191505060405180910390f35b34801561019b57600080fd5b506101a46103fd565b604051808215151515815260200191505060405180910390f35b3480156101ca57600080fd5b506101ff600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919050505061045f565b6040518082815260200191505060405180910390f35b60008060009150600090505b6000805490508110156102b95760008181548110151561023d57fe5b9060005260206000200160000160159054906101000a900460ff1680156102a2575082600281111561026b57fe5b60008281548110151561027a57fe5b9060005260206000200160000160149054906101000a900460ff1660028111156102a057fe5b145b156102ae576001820191505b600181019050610221565b505050565b600080600290506102ce33610326565b15156102d957600080fd5b6102e23361033b565b9150826000838154811015156102f457fe5b9060005260206000200160000160146101000a81548160ff0219169083600281111561031c57fe5b0217905550505050565b6000806103328361033b565b12159050919050565b600080600090505b6000805490508110156103d3578273ffffffffffffffffffffffffffffffffffffffff1660008281548110151561037657fe5b9060005260206000200160000160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614156103c8578091506103f7565b600181019050610343565b7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff91505b50919050565b600080600090505b6000805490508110156104565760008181548110151561042157fe5b9060005260206000200160000160159054906101000a900460ff16151561044b576000915061045b565b600181019050610405565b600191505b5090565b60003373ffffffffffffffffffffffffffffffffffffffff16600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff161415156104bd57600080fd5b6104c682610326565b156104d057600080fd5b60006060604051908101604052808473ffffffffffffffffffffffffffffffffffffffff16815260200160028081111561050657fe5b81526020016000151581525090806001815401808255809150509060018203906000526020600020016000909192909190915060008201518160000160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060208201518160000160146101000a81548160ff021916908360028111156105a457fe5b021790555060408201518160000160156101000a81548160ff02191690831515021790555050505060016000805490500390509190505600a165627a7a72305820c0353738346b316c31e8aae3b67e62a48e6d41629458462c10cebd81adbad4880029'
]

{ #category : #'as yet unclassified' }
FogEVMByteCodeTest >> runtime [
	^ FogEVMByteCode
		fromBinary:
			'0x608060405260043610610078576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063067e050f1461007d578063b3f98adc146100ad578063c3c5a547146100dd578063c88b2aac14610138578063cea6cf5e1461018f578063f4ab9adf146101be575b600080fd5b34801561008957600080fd5b506100ab600480360381019080803560ff169060200190929190505050610215565b005b3480156100b957600080fd5b506100db600480360381019080803560ff1690602001909291905050506102be565b005b3480156100e957600080fd5b5061011e600480360381019080803573ffffffffffffffffffffffffffffffffffffffff169060200190929190505050610326565b604051808215151515815260200191505060405180910390f35b34801561014457600080fd5b50610179600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919050505061033b565b6040518082815260200191505060405180910390f35b34801561019b57600080fd5b506101a46103fd565b604051808215151515815260200191505060405180910390f35b3480156101ca57600080fd5b506101ff600480360381019080803573ffffffffffffffffffffffffffffffffffffffff16906020019092919050505061045f565b6040518082815260200191505060405180910390f35b60008060009150600090505b6000805490508110156102b95760008181548110151561023d57fe5b9060005260206000200160000160159054906101000a900460ff1680156102a2575082600281111561026b57fe5b60008281548110151561027a57fe5b9060005260206000200160000160149054906101000a900460ff1660028111156102a057fe5b145b156102ae576001820191505b600181019050610221565b505050565b600080600290506102ce33610326565b15156102d957600080fd5b6102e23361033b565b9150826000838154811015156102f457fe5b9060005260206000200160000160146101000a81548160ff0219169083600281111561031c57fe5b0217905550505050565b6000806103328361033b565b12159050919050565b600080600090505b6000805490508110156103d3578273ffffffffffffffffffffffffffffffffffffffff1660008281548110151561037657fe5b9060005260206000200160000160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614156103c8578091506103f7565b600181019050610343565b7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff91505b50919050565b600080600090505b6000805490508110156104565760008181548110151561042157fe5b9060005260206000200160000160159054906101000a900460ff16151561044b576000915061045b565b600181019050610405565b600191505b5090565b60003373ffffffffffffffffffffffffffffffffffffffff16600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff161415156104bd57600080fd5b6104c682610326565b156104d057600080fd5b60006060604051908101604052808473ffffffffffffffffffffffffffffffffffffffff16815260200160028081111561050657fe5b81526020016000151581525090806001815401808255809150509060018203906000526020600020016000909192909190915060008201518160000160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555060208201518160000160146101000a81548160ff021916908360028111156105a457fe5b021790555060408201518160000160156101000a81548160ff02191690831515021790555050505060016000805490500390509190505600a165627a7a72305820c0353738346b316c31e8aae3b67e62a48e6d41629458462c10cebd81adbad4880029'
]

{ #category : #initialization }
FogEVMByteCodeTest >> setUp [
	super setUp.
	binary := self binary.
	runtime := self runtime. 

]

{ #category : #initialization }
FogEVMByteCodeTest >> testBinaryByteCodeIsBinary [
	self assert: binary isBinary 
]

{ #category : #initialization }
FogEVMByteCodeTest >> testBinaryByteCodeIsNotRuntime [
	self deny: binary isRuntime  
]

{ #category : #initialization }
FogEVMByteCodeTest >> testBinaryCodeStreamConstructorHasMethodLookup [
	self assert: binary readStream nextMethodLookup isNotEmpty
]

{ #category : #initialization }
FogEVMByteCodeTest >> testBinaryCodeStreamHasConstructor [
	self assert: binary readStream nextConstructor isNotEmpty
]

{ #category : #initialization }
FogEVMByteCodeTest >> testBinaryNextMethodGivesAStream [
	| stream |
	stream := binary readStream.
	stream nextConstructor.
	stream nextMethodLookup.
	self assert: (stream nextMethod isKindOf: FogEVMMethodBytecodeStream).
	
]

{ #category : #initialization }
FogEVMByteCodeTest >> testBinaryPollHas6Methods [
	| stream |
	stream := binary readStream.
	stream nextConstructor. 
	stream nextMethodLookup.
	6 timesRepeat: [ stream nextMethod ].
	self should: [ stream nextMethod ] raise: Error
]

{ #category : #initialization }
FogEVMByteCodeTest >> testRuntimeByteCodeIsNotBinary [
	self deny: runtime isBinary 
]

{ #category : #initialization }
FogEVMByteCodeTest >> testRuntimeByteCodeIsRuntime [
	self assert: runtime isRuntime
]

{ #category : #initialization }
FogEVMByteCodeTest >> testRuntimeCodeStreamConstructorHasMethodLookup [
	self assert: runtime readStream nextMethodLookup isNotEmpty
]

{ #category : #initialization }
FogEVMByteCodeTest >> testRuntimeCodeStreamConstructorRaisesException [
	self should: [ runtime readStream nextConstructor ] raise: Error
]

{ #category : #initialization }
FogEVMByteCodeTest >> testRuntimeNextMethodGivesAStream [
	| stream |
	stream := runtime readStream.
	stream nextMethodLookup.
	self assert: (stream nextMethod isKindOf: FogEVMMethodBytecodeStream)
]

{ #category : #initialization }
FogEVMByteCodeTest >> testRuntimePollHas6Methods [
	| stream |
	stream := runtime readStream.
	stream nextMethodLookup.
	6 timesRepeat: [ stream nextMethod ].
	self should: [ stream nextMethod ] raise: Error
]
