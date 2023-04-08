//SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract NFT {
string name;
string symbol;
uint256 TokenId;
uint256 TotalSupply;
address public Owner;

event Mint(address to, uint id, uint time);
event Transfer(address to, uint tokenId, uint amount);
event Burn(address to, uint tokenId, uint amount);
mapping(address => uint) toOwner;
mapping(address => uint) balances;

constructor(string memory _name,string memory _symbol, uint256  _TokenId, uint256  _TotalSupply ) payable {
name = _name;
symbol =_symbol;
TokenId = _TokenId;
TotalSupply = _TotalSupply;
Owner = msg.sender;
}

function mint(address _to, uint256 _tokenId) external {
    require(_to != address(0), "Invalid address");
    require(_tokenId != 0, "Invalid ID");

    toOwner[_to] = _tokenId;
    TotalSupply = TotalSupply + 1; 
    balances[_to] = balances[_to] + 1;

    emit Mint(_to, _tokenId, block.timestamp);
}

function transfer(address _to, uint _tokenId, uint _amount) public {
    require(_to != address(0), "Invalid address");
    require(_tokenId != 0, "Invalid ID");

    balances[msg.sender] = balances[msg.sender] - _amount;
    balances[_to] = balances[_to] + _amount;

    emit Transfer(_to, _tokenId, _amount);
}
 
 
 function burn(address _to, uint _tokenId, uint _amount)external {
    require(msg.sender == Owner, "Only the owner can burn tokens");
        require(_amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= _amount;
        TotalSupply -= _amount;

        transfer(address(0), _tokenId, _amount );

        emit Burn(_to, _tokenId, _amount);
 }
 
 
}