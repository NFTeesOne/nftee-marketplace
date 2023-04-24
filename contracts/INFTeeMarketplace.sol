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
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract,
        Listing listing
    );

    event NFTeeUpdated(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract,
        Listing listing
    );

    event NFTeeSold(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract,
        uint256 tokenId,
        address buyer,
        uint256 quantity,
        uint256 totalPrice
    );

    event NFTeeRemoved(
        uint256 indexed listingId,
        address indexed seller
    );

    function listNFTee(ListingParameters calldata _listingParameters) external returns (uint256 listingId);

    function updateNFTee(uint256 _listingId, ListingParameters calldata _listingParameters) external;

    function buyNFTee(uint256 _listingId, address _sendTo, uint256 _quantity, uint256 _totalPrice) external payable;

    function removeNFTee(uint256 _listingId) external;

    function getTotalListings() external view returns (uint256);

    function getListing(uint256 _listingId) external view returns (Listing memory listing);

    function getAllActiveListings(uint256 _startId, uint256 _endId) external view returns (Listing[] memory listings);

    function getAllHistoricalListings(uint256 _startId, uint256 _endId) external view returns (Listing[] memory listings);
}