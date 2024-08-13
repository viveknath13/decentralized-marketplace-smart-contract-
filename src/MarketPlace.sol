// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract DecentralizedMarketplace {
    // Data structure to store information about each item
    struct Item {
        string name;
        string description;
        uint256 price;
        address seller;
        bool available;
    }

    // Mapping of item IDs to items
    mapping(uint256 => Item) public items;

    // Mapping of seller addresses to their balances
    mapping(address => uint256) public sellerBalances;

    // Next item ID
    uint256 public nextItemId;

    // Event emitted when an item is listed
    event ItemListed(uint256 itemId, string name, uint256 price, address seller);

    // Event emitted when an order is placed
    event OrderPlaced(uint256 itemId, address buyer);

    // Event emitted when a transaction is completed
    event TransactionCompleted(uint256 itemId, address buyer, address seller);

    // List an item for sale
    function listItem(string memory _name, string memory _description, uint256 _price) public {
        // Create a new item
        Item memory item = Item(_name, _description, _price, msg.sender, true);

        // Add the item to the mapping
        items[nextItemId] = item;

        // Emit the ItemListed event
        emit ItemListed(nextItemId, _name, _price, msg.sender);

        // Increment the next item ID
        nextItemId++;
    }

    // Place an order for an item
    function placeOrder(uint256 _itemId) public payable {
        // Get the item
        Item storage item = items[_itemId];

        // Check if the item is available
        require(item.available, "Item is not available");

        // Check if the buyer has sent enough funds
        require(msg.value >= item.price, "Insufficient funds");

        // Update the item's availability
        item.available = false;

        // Emit the OrderPlaced event
        emit OrderPlaced(_itemId, msg.sender);
    }

    // Confirm the completion of a successful transaction
    function confirmTransaction(uint256 _itemId) public {
        // Get the item
        Item storage item = items[_itemId];

        // Check if the item is not available (i.e., it has been ordered)
        require(!item.available, "Item is still available");

        // Transfer the funds to the seller
        payable(item.seller).transfer(item.price);

        // Update the seller's balance
        sellerBalances[item.seller] += item.price;

        // Emit the TransactionCompleted event
        emit TransactionCompleted(_itemId, msg.sender, item.seller);
    }

    // Get the details of an item
    function getItem(uint256 _itemId) public view returns (string memory, string memory, uint256, address, bool) {
        // Get the item
        Item storage item = items[_itemId];

        // Return the item's details
        return (item.name, item.description, item.price, item.seller, item.available);
    }

    // Withdraw funds by a seller
    function withdrawFunds() public {
        // Get the seller's balance
        uint256 balance = sellerBalances[msg.sender];

        // Check if the seller has a balance
        require(balance > 0, "No balance to withdraw");

        // Transfer the balance to the seller
        payable(msg.sender).transfer(balance);

        // Reset the seller's balance
        sellerBalances[msg.sender] = 0;
    }
}