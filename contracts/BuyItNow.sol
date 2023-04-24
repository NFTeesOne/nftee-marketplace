// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title Buy It Now Interface Implementation
/// @author NFTeesOne - https://nftees.one
/// @author haz3141 - https://hazael.io
/// @notice This contract is used to implement the Buy It Now Interface

import { IBuyItNow } from "./INFTeeMarketplace.sol";

contract BuyItNow is IBuyItNow {
    struct Data {
        uint256 totalListings;
        mapping(uint256 => IBuyItNow.Listing) listings;
    }

    function listNFTee(ListingParameters calldata _listingParameters) external returns (uint256 listingId) {
        // set the listing id that will be set for the new listing
        // set the seller address
        // set start time 
        // set end time
        // require that the end time is greater than the start time
        // if start time is less than block.timestamp then ...
        // ... require that start time + 60 minutes be greater than or
    }
}