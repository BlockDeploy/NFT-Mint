
### Instructions for Using NFTMint

**Description:**  This is an ERC-721 standard contract for creating unique non-fungible tokens (NFTs).  
It allows you to mint NFTs with unique identifiers and metadata (e.g., links to images), transfer them to other addresses,  
and burn (destroy) them. It serves as a foundation for digital assets — artwork, collectibles, or in-game items.  
The contract uses OpenZeppelin's ERC-721 standard, making your NFTs compatible with popular platforms like OpenSea or MetaMask.  
**What it offers:**  You can create your own collection of unique digital assets with provable ownership on the blockchain,  
which can be sold, traded, or used in projects — perfect for artists, game developers, or collectors.  
For example, if you have an image and want to create 100 NFTs, this contract will help you achieve that.

**Compilation:**  Go to the "Deploy Contracts" page in BlockDeploy,  
paste the code into the "Contract Code" field (it includes imports from OpenZeppelin libraries),  
select Solidity version 0.8.4 from the dropdown menu (available within the range 0.5.0–0.8.29),  
click "Compile" — the "ABI" and "Bytecode" fields will populate automatically.

**Deployment:**  In the "Deploy Contract" section, select the network (e.g., Ethereum Mainnet or a testnet),  
enter the private key of a wallet with ETH into the "Private Key" field,  
leave the constructor parameters empty (defaults to collection name "MyNFTCollection" and symbol "MNFT"),  
click "Deploy" and confirm in the modal window. After deployment, you’ll become the contract owner and can start minting NFTs.

**How to Create 100 NFTs from One Image:**  
If you have an image (e.g., "my_image.png") and want to create a collection of 100 NFTs, here’s a step-by-step guide:  

-   **Upload the Image to IPFS:**  To make the image blockchain-accessible, use IPFS (InterPlanetary File System).  
    - Sign up on  [Pinata.cloud](https://pinata.cloud/)  (an easy option) or install IPFS Desktop from  [the official site](https://ipfs.io/#install).  
    - In Pinata, click "Upload" → "File," select "my_image.png," and upload it. You’ll get a CID, e.g.,  `QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco`.  
    - Image link:  `ipfs://QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco`  or  `https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco`. Test it in your browser.
-   **Create Metadata for 100 NFTs:**  Each NFT needs a JSON file with a name, description, and image link.  
    - Example for token #1:  
    
    {
        "name": "My NFT #1",
        "description": "A unique token from a 100-NFT collection.",
        "image": "ipfs://QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco",
        "attributes": [{"trait_type": "Edition", "value": "1 of 100"}]
    }
    
    - Create 100 files (1.json, 2.json, ..., 100.json). Use this Node.js script:  
    
    const fs = require('fs');
    for (let i = 1; i <= 100; i++) {
        const metadata = {
            name: `My NFT #${i}`,
            description: "A unique token from a 100-NFT collection.",
            image: "ipfs://QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco",
            attributes: [{ trait_type: "Edition", value: `${i} of 100` }]
        };
        fs.writeFileSync(`metadata/${i}.json`, JSON.stringify(metadata, null, 2));
    }
    
    - Create a  `metadata`  folder, save the script as  `generate.js`, install Node.js, and run  `node generate.js`.
-   **Upload Metadata to IPFS:**  Upload the  `metadata`  folder with 100 files.  
    - In Pinata: "Upload" → "Folder" → select  `metadata`. You’ll get a folder CID, e.g.,  `QmYx...`.  
    - The base URI will be:  `ipfs://QmYx.../`. For example, token #1 will be at  `ipfs://QmYx.../1.json`.
-   **Set the Base URI in the Contract:**  After deployment, call the  `setBaseURI`  function,  
    specifying your base URI (e.g.,  `ipfs://QmYx.../`). This links each NFT to its metadata (ID 1 → 1.json, etc.).
-   **Mint 100 NFTs:**  Use  `mintNFT`, calling it 100 times with your address.  
    - In the BlockDeploy interface, locate the deployed contract in the logs, select the  `mintNFT`  function, enter your address (e.g.,  `0xYourAddress`),  
    repeat 100 times (or write a script to automate it with ethers.js/web3.js).

**Using the Finished Collection:**  

-   Transfer NFTs with  `transferNFT`,  
    specifying the recipient’s address and token ID (e.g., 1) — useful for sales or gifting.
-   Burn NFTs with  `burnNFT`,  
    specifying the token ID — removes it from circulation if no longer needed.
-   Check the token owner with  `getOwnerOf`,  
    specifying the ID — useful for verifying ownership.
