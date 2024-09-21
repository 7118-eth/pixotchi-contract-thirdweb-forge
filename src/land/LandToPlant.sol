// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {LibLandToPlant} from "./LibLandToPlant.sol";
import  {ILandToPlant} from "./ILandToPlant.sol";
import  {LandAccessControl} from "./LandAccessControl.sol";

/**
 * @title LandToPlant
 * @author 7118.eth
 * @notice The extension ("facet") for managing plant-related operations in the game
 * @dev This contracts contains functions for calculating rewards, assigning points,
 *      and managing plant lifetimes
 */
contract LandToPlant is ILandToPlant, LandAccessControl {

    function landToPlantAssignPlantPoints(uint256 _nftId, uint256 _addedPoints) onlyAllowedCaller() onlyPlantOwner(_nftId) external returns (uint256 _newPlantPoints)  {
        return LibLandToPlant.assignPlantPoints(_nftId, _addedPoints);
    }


    function landToPlantAssignLifeTime(uint256 _nftId, uint256 _lifetime) onlyAllowedCaller() onlyPlantOwner(_nftId) external returns(uint256 _newLifetime) {
        return LibLandToPlant.assignLifeTime(_nftId, _lifetime);
    }

}
