pragma solidity 0.5.7;
pragma experimental ABIEncoderV2;

import "./LibOrderFill.sol";

contract MultiFillOrder {

    function repro(
        LibOrder.Order[] memory makerOrders,
        uint256[] memory takerAmounts,
        uint256 fillSalt
    ) 
        public
    {
        bytes32 fillHash = LibOrderFill.badFunc(
            makerOrders,
            takerAmounts,
            fillSalt
        );
    }
}