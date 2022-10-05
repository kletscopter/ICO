// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ICryptoDevs.sol";

pragma solidity ^0.8.9;

contract CryptoDevToken is ERC20, Ownable{

    ICryptoDevs CryptoDevsNFT;
    uint256 public constant tokenPrice = 0.001 ether;
    uint256 public constant maxTotalSupply = 10000 * 10**18;
    uint256 public constant tokensPerNFT = 10 * 10**18; //in bignumbers geschreven -> 10 tokens dus
    mapping(uint256 => bool) public tokenIdsClaimed;

    constructor(address _CryptoDevsContract) ERC20("CryptoDevToken", "CDT"){
        CryptoDevsNFT = ICryptoDevs(_CryptoDevsContract);
    }

    function mint(uint256 amount) public payable {
        uint256 _requiredAmount = tokenPrice * amount;
        require(msg.value >= _requiredAmount, "Ether sent is less than 0.001 ether");
        uint256 amountWithDecimals = amount * 10**18;
        require(totalSupply() + amountWithDecimals <= maxTotalSupply, "Exceeds the max total supply");
        _mint(msg.sender, amount);
    }

    function claim() public {
        address sender = msg.sender;
        uint256 balance = CryptoDevsNFT.balanceOf(sender); //balance van het contract
        require(balance > 0, "You don't have an NFT");
         uint256 amount = 0;
        for(uint256 i = 0; i < balance; i++){
            uint256 tokenID = CryptoDevsNFT.tokenOfOwnerByIndex(sender, i); //deze identifier gebruiken om te zien of tokens al zijn opgevraagd of niet
            if(!tokenIdsClaimed[tokenID]){
                tokenIdsClaimed[tokenID] = true;
                amount++;

            }
        }
        require(amount > 0, "You have already claimed all your tokens");
        _mint(msg.sender, amount * tokensPerNFT);
    }

    receive() external payable{}

    fallback() external payable{}

}