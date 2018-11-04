Class {
	#name : #FogEVMTestOverContract,
	#superclass : #TestCase,
	#instVars : [
		'interpreter'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #'as yet unclassified' }
FogEVMTestOverContract class >> sellContractByteCode [
	^ FogEVMByteCode fromBinary:  '608060405234801561001057600080fd5b506040516104e23803806104e28339810180604052810190808051906020019092919080518201929190505050336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555080600490805190602001906100939291906100a2565b50816003819055505050610147565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100e357805160ff1916838001178555610111565b82800160010185558215610111579182015b828111156101105782518255916020019190600101906100f5565b5b50905061011e9190610122565b5090565b61014491905b80821115610140576000816000905550600101610128565b5090565b90565b61038c806101566000396000f300608060405260043610610062576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680630ff8d8a514610067578063a6f2ae3a146100aa578063d28cebb8146100b4578063de822f83146100cb575b600080fd5b34801561007357600080fd5b506100a8600480360381019080803573ffffffffffffffffffffffffffffffffffffffff1690602001909291905050506100e2565b005b6100b26101d9565b005b3480156100c057600080fd5b506100c961028c565b005b3480156100d757600080fd5b506100e06102b2565b005b3373ffffffffffffffffffffffffffffffffffffffff166000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614801561016357506002600381111561014657fe5b600560009054906101000a900460ff16600381111561016157fe5b145b156101d6578073ffffffffffffffffffffffffffffffffffffffff166108fc6003549081150290604051600060405180830381858888f193505050501580156101b0573d6000803e3d6000fd5b506003600560006101000a81548160ff021916908360038111156101d057fe5b02179055505b50565b600060038111156101e657fe5b600560009054906101000a900460ff16600381111561020157fe5b14151561020d5761028a565b3460035414151561021d57600080fd5b6001600560006101000a81548160ff0219169083600381111561023c57fe5b02179055503460028190555033600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505b565b6000600560006101000a81548160ff021916908360038111156102ab57fe5b0217905550565b3373ffffffffffffffffffffffffffffffffffffffff16600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1614801561033457506001600381111561031757fe5b600560009054906101000a900460ff16600381111561033257fe5b145b1561035e576002600560006101000a81548160ff0219169083600381111561035857fe5b02179055505b5600a165627a7a72305820855aeb1af37be342b18af870e7d50eef8b8b335d134e32b684d374196442fddc0029'
]

{ #category : #'as yet unclassified' }
FogEVMTestOverContract class >> sellContractSrc [
	^ 'pragma solidity ^0.4.8;

contract Sell {
	
	enum State { ON_SALE, WAITING_SEND, SENT, FINISH } 
	
	address _owner;
	address buyer;
	uint payed;
	uint price;
	string itemName;
	
	State state; 
	
	function Sell (uint toPay, string name) public {
		_owner = msg.sender; 
                itemName = name;
   	        price = toPay;
	}
    function prepare() public {
	state = State.ON_SALE;
    }
    function buy() payable public {
		if (state != State.ON_SALE) { return ; }
		if( price != msg.value ) revert(); 
		state = State.WAITING_SEND;
		payed = msg.value;
		buyer = msg.sender;
    }

    function informItemReceived  () public {
		if ( buyer == msg.sender && state == State.WAITING_SEND ) {
			state = State.SENT;
		}
    }

    function withdrawMoneyTo  (address toAddress) public{
		if ( _owner == msg.sender && state == State.SENT) {
			toAddress.transfer(price);
			state = State.FINISH;
		}
    }
}
'
]

{ #category : #running }
FogEVMTestOverContract >> setUp [ 	
	super setUp.
	interpreter := FogEVMTestInterpreter new.
	interpreter call: FogEVMInterpreter creationCall.
	interpreter bytecode: self class sellContractByteCode .
]

{ #category : #running }
FogEVMTestOverContract >> testContractIsDeployed [ 
	interpreter run. 
	self halt. 
	 
]
