// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.0/contracts/access/Ownable.sol";

contract NFTMint is ERC721, Ownable {
    // Token counter for unique IDs
    uint256 public tokenIdCounter;
    // Base URI for token metadata
    string private _baseTokenURI;

    // Events are already defined in ERC721, but we add our own for minting
    event NFTMinted(address indexed to, uint256 indexed tokenId);

    // Constructor with collection name and symbol
    constructor() ERC721("MyNFTCollection", "MNFT") {
        tokenIdCounter = 1;
        _baseTokenURI = "https://example.com/metadata/";
    }

    // Function to set the base metadata URI (only owner)
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    // Override of baseURI function from ERC721
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    // Function to mint a new NFT
    function mintNFT(address to) public onlyOwner returns (uint256) {
        require(to != address(0), "Cannot mint to zero address");
        uint256 newTokenId = tokenIdCounter;
        _safeMint(to, newTokenId);
        tokenIdCounter += 1;
        emit NFTMinted(to, newTokenId);
        return newTokenId;
    }

    // Function to burn an NFT
    function burnNFT(uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Caller is not owner nor approved");
        _burn(tokenId);
    }

    // Function to transfer an NFT (already in ERC721, included for clarity)
    function transferNFT(address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Caller is not owner nor approved");
        safeTransferFrom(msg.sender, to, tokenId);
    }

    // Function to check the owner of a token
    function getOwnerOf(uint256 tokenId) public view returns (address) {
        return ownerOf(tokenId);
    }
}