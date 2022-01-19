// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
interface IMultiSig{
function submitTransaction(
        address _to,
        uint _value,
        bytes memory _data
    ) external;
function confirmTransaction(uint _txIndex) external view returns(bool);
function executeTransaction(uint _txIndex) external;
function revokeConfirmation(uint _txIndex) external;
function getOwners() external view returns (address[] memory);
function getTransactionCount() external view returns (uint);
function getTransaction(uint _txIndex)
        external
        view
        returns (
            address to,
            uint value,
            bytes memory data,
            bool executed,
            uint numConfirmations
        )


}