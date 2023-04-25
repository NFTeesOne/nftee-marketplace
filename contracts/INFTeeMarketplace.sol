// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/// @title NFTee Marketplace Interface
/// @author NFTeesOne - https://nftees.one
/// @author haz3141 - https://hazael.io
/// @notice Interface for the NFTee Marketplace contract
/// @dev This contains multiple interfaces for the NFTee Marketplace

/**
 * @title Buy It Now Interface
 * @notice Interface for listing NFTees at a set price
 * @dev This is a subset of the NFTee Marketplace interface
 */
interface IBuyItNow {
    enum Status { Open, Sold, Removed }

    /// @dev Parameters for listing an NFTee
    struct ListingParameters {
        address nfteeContract;
        uint256 tokenId;
        uint256 quantity;
        uint256 price;
        uint256 royalty;
        address royaltyRecipient;
        uint128 startTimestamp;
        uint128 endTimestamp;
    }

    /// @dev Data contained in a listing
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

    /// @dev Emitted when an NFTee is listed
    event NFTeeListed(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract,
        Listing listing
    );

    /// @dev Emitted when an NFTee is updated
    event NFTeeUpdated(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract,
        Listing listing
    );

    /// @dev Emitted when an NFTee is sold
    event NFTeeSold(
        uint256 indexed listingId,
        address indexed seller,
        address indexed nfteeContract,
        uint256 tokenId,
        address buyer,
        uint256 quantity,
        uint256 totalPrice
    );

    /// @dev Emitted when an NFTee is removed
    event NFTeeRemoved(
        uint256 indexed listingId,
        address indexed seller
    );

    /**
     * @notice List an NFTee for sale at a set price
     * @param _listingParameters Parameters for listing an NFTee
     * @return listingId ID of the listing
     */
    function listNFTee(ListingParameters calldata _listingParameters) external returns (uint256 listingId);

    /**
     * @notice Update an NFTee listing
     * @param _listingId ID of the listing
     * @param _listingParameters Parameters for listing an NFTee
     */
    function updateNFTee(uint256 _listingId, ListingParameters calldata _listingParameters) external;

    /**
     * @notice Buy an NFTee
     * @param _listingId ID of the listing
     * @param _sendTo Address to send the NFTee to
     * @param _quantity Quantity of the NFTee to buy
     * @param _totalPrice Total price of the purchase
     */
    function buyNFTee(uint256 _listingId, address _sendTo, uint256 _quantity, uint256 _totalPrice) external payable;

    /**
     * @notice Remove an NFTee listing
     * @param _listingId ID of the listing
     */
    function removeNFTee(uint256 _listingId) external;

    /**
     * @notice Get the total number of listings
     * @return totalListings Total number of listings
     */
    function getTotalListings() external view returns (uint256);

    /**
     * @notice Get a listing
     * @param _listingId ID of the listing
     * @return listing Listing data
     */
    function getListing(uint256 _listingId) external view returns (Listing memory listing);

    /**
     * @notice Get all active listings
     * @param _startId ID of the first listing
     * @param _endId ID of the last listing
     * @return listings Array of listings
     */
    function getAllActiveListings(uint256 _startId, uint256 _endId) external view returns (Listing[] memory listings);

    /**
     * @notice Get all historical listings
     * @param _startId ID of the first listing
     * @param _endId ID of the last listing
     * @return listings Array of listings
     */
    function getAllHistoricalListings(uint256 _startId, uint256 _endId) external view returns (Listing[] memory listings);
}