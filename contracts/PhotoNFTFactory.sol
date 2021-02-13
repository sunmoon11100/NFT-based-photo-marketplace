pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

import { SafeMath } from "./openzeppelin-solidity/contracts/math/SafeMath.sol";
import { PhStorage } from "./storage/PhStorage.sol";
import { PhOwnable } from "./modifiers/PhOwnable.sol";
import { PhotoNFT } from "./PhotoNFT.sol";


/**
 * @notice - This is the factory contract for a NFT of photo
 */
contract PhotoNFTFactory is PhStorage, PhOwnable {
    using SafeMath for uint256;
    
    address[] public photoAddresses;

    constructor() public {}

    function createNewPhotoNFT(string memory nftName, string memory nftSymbol, uint photoPrice, string memory ipfsHashOfPhoto) public returns (bool) {
        PhotoNFT photoNFT = new PhotoNFT(nftName, nftSymbol);
        photoAddresses.push(address(photoNFT));

        photoNFT.savePhotoNFTData(nftName, nftSymbol, msg.sender, photoPrice, ipfsHashOfPhoto);        

        /// Save metadata of a photoNFT
        _saveMetadataOfPhotoNFT(photoNFT, nftName, nftSymbol, msg.sender, photoPrice, ipfsHashOfPhoto);
    }


    /**
     * @notice - Save metadata of a photoNFT
     */
    function _saveMetadataOfPhotoNFT(PhotoNFT _photoNFT, string memory _photoNFTName, string memory _photoNFTSymbol, address _ownerAddress, uint _photoPrice, string memory _ipfsHashOfPhoto) internal returns (bool) {
        // Save metadata of a photoNFT of photo
        Photo memory photo = Photo({
            photoNFT: _photoNFT,
            photoNFTName: _photoNFTName,
            photoNFTSymbol: _photoNFTSymbol,
            ownerAddress: _ownerAddress,
            photoPrice: _photoPrice,
            ipfsHashOfPhoto: _ipfsHashOfPhoto,
            reputation: 0
        });
        photos.push(photo);        
    }


    ///-----------------
    /// Getter methods
    ///-----------------
    function getPhoto(uint index) public view returns (Photo memory _photo) {
        Photo memory photo = photos[index];
        return photo;
    }

    function getAllPhotos() public view returns (Photo[] memory _photos) {
        return photos;
    }
}
