# endChallenge Smart Contract

## Description

The `endChallenge` smart contract is designed to handle simple deposit and withdrawal operations. It allows the contract owner to withdraw funds and emit events for deposits and withdrawals. The contract also includes functions to demonstrate the use of error handling statements (`require`, `assert`, and `revert`) in Solidity.

## Features

- **Deposit Ether**: Any user can deposit Ether into the contract.
- **Withdraw Ether**: Only the contract owner can withdraw Ether from the contract.
- **Event Emission**: Emits events for deposit and withdrawal operations.
- **Error Handling**: Demonstrates the use of `require`, `assert`, and `revert`.

## Functions

### Constructor

```solidity
constructor() {
    owner = msg.sender;
}
```

The constructor sets the deployer of the contract as the owner.

### deposit()

```solidity
function deposit() public payable {
    require(msg.value > 0, "Please deposit amount which is greater than zero");
    balance += msg.value;
    emit Deposit(msg.sender, msg.value);
}
```

Allows any user to deposit Ether into the contract. The deposited amount must be greater than zero. Emits a `Deposit` event upon successful deposit.

### withdraw()

```solidity
function withdraw(uint256 amount) public {
    require(msg.sender == owner, "Are you the owner? only owner can withdraw funds");
    require(amount <= balance, "The balance is insufficient");

    balance -= amount;

    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");

    emit Withdraw(msg.sender, amount);
}
```

Allows the contract owner to withdraw a specified amount of Ether from the contract. The amount must not exceed the contract's balance. Emits a `Withdraw` event upon successful withdrawal.

### triggerAssert()

```solidity
function triggerAssert() public view {
    assert(balance >= 0); // This should always be true
}
```

Demonstrates the use of the `assert` statement. The assertion checks that the contract's balance is non-negative.

### triggerRevert()

```solidity
function triggerRevert() public pure {
    revert("This function always reverts");
}
```

Demonstrates the use of the `revert` statement. This function always reverts with a custom error message.

## Events

### Deposit

```solidity
event Deposit(address indexed sender, uint256 amount);
```

Emitted when Ether is deposited into the contract. The `sender` is the address of the depositor, and `amount` is the amount of Ether deposited.

### Withdraw

```solidity
event Withdraw(address indexed receiver, uint256 amount);
```

Emitted when Ether is withdrawn from the contract. The `receiver` is the address of the withdrawer, and `amount` is the amount of Ether withdrawn.

## Usage

### Deployment

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file and paste the contract code.
3. Compile the contract using the Solidity compiler.
4. Deploy the contract to your preferred network (e.g., JavaScript VM, Injected Web3).

### Interacting with the Contract

1. **Deposit Ether**:
   - Ensure you have some Ether in your account.
   - Specify the amount of Ether to send in the "Value" field in Remix.
   - Call the `deposit` function.

2. **Withdraw Ether**:
   - Ensure you are the contract owner.
   - Call the `withdraw` function with the amount to withdraw.

3. **Trigger Assertion**:
   - Call the `triggerAssert` function to verify that the balance is non-negative.

4. **Trigger Revert**:
   - Call the `triggerRevert` function to see it revert with the custom message.



## License

This project is licensed under the MIT License.
