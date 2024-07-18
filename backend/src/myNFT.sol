// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 public tokenCounter;
    
    mapping (uint256 => string) private _tokenURIs;

    constructor() ERC721("MyNFT", "NFT") Ownable(msg.sender) {
        tokenCounter = 0;
    }

    function mintNFT(address recipient, string memory _tokenURI) public onlyOwner returns (uint256) {
        uint256 newItemId = tokenCounter;
        _mint(recipient, newItemId);
        _setTokenURIInternal(newItemId, _tokenURI);
        tokenCounter++;
        return newItemId;
    }

    function _setTokenURIInternal(uint256 tokenId, string memory _tokenURI) internal virtual {
        _tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
