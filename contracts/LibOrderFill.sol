pragma solidity 0.5.7;
pragma experimental ABIEncoderV2;

import "./LibOrder.sol";


library LibOrderFill {
    function getHash(
        LibOrder.Order memory order,
        uint256 takerAmount,
        uint256 fillSalt
    )
        internal
        pure
        returns (bytes32)
    {
        return keccak256(
            abi.encodePacked(
                order.a,
                order.b,
                order.c,
                order.d,
                order.e,
                order.f,
                order.g,
                order.h,
                order.i,
                order.j,
                order.k,
                takerAmount,
                fillSalt
            )
        );
    }

    function badFunc(
        LibOrder.Order[] memory orders,
        uint256[] memory takerAmounts,
        uint256 fillSalt
    )
        internal
        pure
        returns (bytes32)
    {
        bytes32 fillMultipleOrderHash = getHash(
            orders[0],
            takerAmounts[0],
            fillSalt
        );
        if (orders.length == 1) {
            return fillMultipleOrderHash;
        }
        for (uint256 i = 1; i < orders.length; i++) {
            bytes32 metaFillHash = getHash(
                orders[i],
                takerAmounts[i],
                fillSalt
            );
            fillMultipleOrderHash = keccak256(
                abi.encodePacked(
                    fillMultipleOrderHash, 
                    metaFillHash
                )
            );
        }
        return fillMultipleOrderHash;
    }
}