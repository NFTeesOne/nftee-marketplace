// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title NFTee Marketplace Interface
/// @author NFTeesOne - https://nftees.one
/// @author haz3141 - https://hazael.io
/// @notice Interface for the NFTee Marketplace contract
/// @dev This contains multiple interfaces for the NFTee Marketplace

/**
 * @title Buy It Now Interface
 * @notice Interface for listing tokens at a set price
 */
interface IBuyItNow {
    enum Status { Open, Sold, Removed }

    struct ListingParameters {
        address nfteeContract;
        uint256 tokenId;
        uint256 quantity;
        uint256 price;
        uint256 royalty;
        uint256 royaltyRecipient;
        uint128 startTimestamp;
        uint128 endTimestamp;
    }

    struct Listing {
        uint256 listingId;
        address seller;
        address nfteeContract;
        uint256 tokenId;
        uint256 quantity;
        uint256 price;
        uint256 royalty;
        address royaltyRecipient;
        uint128 startTimestamp;
        uint128 endTimestamp;
        Status status;
    }

    event NFTeeListed(
        uint256 indexed tokenId,
        address indexed seller,
        address indexed nfteeContract,
        Listing listing
    );

    event NFTeeSold(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract
        uint256 tokenId,
        address buyer,
        uint256 quantity,
        uint256 totalPrice
    );

    event NFTeeRemoved(
        address indexed seller,
        uint256 indexed listingId
    );
}