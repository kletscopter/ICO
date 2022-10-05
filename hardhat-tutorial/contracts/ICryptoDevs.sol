// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ICryptoDevs {

    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256); //returns the token ID at a given index
    function balanceOf(address owner) external view returns (uint256 balance);

    
}