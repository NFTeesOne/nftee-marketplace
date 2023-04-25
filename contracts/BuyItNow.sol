// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title Buy It Now Interface Implementation
/// @author NFTeesOne - https://nftees.one
/// @author haz3141 - https://hazael.io
/// @notice This contract is used to implement the Buy It Now Interface

import { IBuyItNow } from "./INFTeeMarketplace.sol";

contract BuyItNow is IBuyItNow {
        uint256 private totalListings;
        mapping(uint256 => Listing) private listings;

    /*///////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
    ///////////////////////////////////////////////////////////////*/
    function listNFTee(ListingParameters calldata _listingParameters) external returns (uint256 listingId) {
        listingId = _getNextListingId();
        address seller = msg.sender;
       
        require(_listingParameters.endTimestamp > _listingParameters.startTimestamp, "End timestamp must be greater than start timestamp.");

        uint128 startTime = _listingParameters.startTimestamp;
        uint128 endTime = _listingParameters.endTimestamp;
        if (startTime < block.timestamp) {
            startTime = uint128(block.timestamp);
            // TODO: adjust end time
        }

        // TODO: validate listing data

        Listing memory newListing = Listing({
            listingId: listingId,
            seller: seller,
            nfteeContract: _listingParameters.nfteeContract,
            tokenId: _listingParameters.tokenId,
            quantity: _listingParameters.quantity,
            price: _listingParameters.price,
            royalty: _listingParameters.royalty,
            royaltyRecipient: _listingParameters.royaltyRecipient,
            startTimestamp: startTime,
            endTimestamp: _listingParameters.endTimestamp,
            status: Status.Open
        });

        listings[listingId] = newListing;

        emit NFTeeListed(listingId, seller, _listingParameters.nfteeContract, newListing);
    }

    /*///////////////////////////////////////////////////////////////
                            INTERNAL FUNCTIONS    
    ///////////////////////////////////////////////////////////////*/

    /// @dev Returns the next listing Id
    function _getNextListingId() internal returns (uint256 nextListingId) {
        nextListingId = totalListings;
        totalListings += 1;
    }
}