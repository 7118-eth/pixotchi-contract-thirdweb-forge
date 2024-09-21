// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {LibLandToPlant} from "./LibLandToPlant.sol";
import  {ILandToPlant} from "./ILandToPlant.sol";

/**
 * @title LandToPlant
 * @author 7118.eth
 * @notice The extension ("facet") for managing plant-related operations in the game
 * @dev This contracts contains functions for calculating rewards, assigning points,
 *      and managing plant lifetimes
 */
contract LandToPlant is ILandToPlant {

    function landToPlantAssignPlantPoints(uint256 _nftId, uint256 _addedPoints) external returns (uint256 _newPlantPoints) {
        //TODO: security check. only land contract should be able to call this. 
        //TODO: we have to also make sure that the tx is form the owner.
        return LibLandToPlant.assignPlantPoints(_nftId, _addedPoints);
    }


    function landToPlantAssignLifeTime(uint256 _nftId, uint256 _lifetime) external returns(uint256 _newLifetime) {
                //TODO: security check. only land contract should be able to call this. 
        //TODO: we have to also make sure that the tx is form the owner.
        return LibLandToPlant.assignLifeTime(_nftId, _lifetime);
    }

}
