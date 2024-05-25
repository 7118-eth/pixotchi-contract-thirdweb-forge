// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import "@thirdweb-dev/dynamic-contracts/src/presets/BaseRouter.sol";
import {BaseRouter, IRouter, IRouterState} from "../../lib/dynamic-contracts/src/presets/BaseRouter.sol";
import  "../../lib/contracts/contracts/extension/upgradeable/PermissionsEnumerable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/Initializable.sol";
import "../../lib/contracts/contracts/extension/upgradeable/init/ReentrancyGuardInit.sol";
import "../../lib/contracts/contracts/extension/upgradeable/ReentrancyGuard.sol";
import "../utils/FixedPointMathLib.sol";

//import "../lib/contracts/contracts/eip/ERC721AUpgradeable.sol";

import "../game/GameStorage.sol";




contract PixotchiRouter is
    Initializable,
    BaseRouter,
    PermissionsEnumerable,
    ReentrancyGuardInit,
    ReentrancyGuard//,
    //ERC721AUpgradeable
{
    /// @dev Only EXTENSION_ROLE holders can perform upgrades.
    bytes32 private constant EXTENSION_ROLE = keccak256("EXTENSION_ROLE");

    bytes32 private constant MODULE_TYPE = bytes32("PixotchiV2");
    uint256 private constant VERSION = 1;

    //address public tokenAddress;

    /// @dev We accept constructor params as a struct to avoid `Stack too deep` errors.
    struct SimpleRouterConstructorParams {
        Extension[] extensions;
        //address tokenAddress;
    }



    constructor(
        SimpleRouterConstructorParams memory _simpleRouterV3Params
    ) BaseRouter(_simpleRouterV3Params.extensions)  {
          __BaseRouter_init();
        //_disableInitializers();

    }

    receive() external payable {
        GameStorage.Data storage _s = GameStorage.data();
        _s.ethAccPerShare += FixedPointMathLib.mulDivDown(msg.value, _s.PRECISION, _s.totalScores);
    }



    /// @dev Initializes the contract, like a constructor.
    function initialize(
    ) external initializer {
    __ReentrancyGuard_init();
    address _defaultAdmin = 0xC3f88d5925d9aa2ccc7b6cb65c5F8c7626591Daf;
    _setupRole(DEFAULT_ADMIN_ROLE, _defaultAdmin);
    _setupRole(EXTENSION_ROLE, _defaultAdmin);
    _setupRole(EXTENSION_ROLE, _defaultAdmin);
    _setRoleAdmin(EXTENSION_ROLE, EXTENSION_ROLE);
    }


    /*///////////////////////////////////////////////////////////////
                        Generic contract logic
    //////////////////////////////////////////////////////////////*/

    /// @dev Returns the type of the contract.
    function contractType() external pure returns (bytes32) {
        return MODULE_TYPE;
    }

    /// @dev Returns the version of the contract.
    function contractVersion() external pure returns (uint8) {
        return uint8(VERSION);
    }

    /*///////////////////////////////////////////////////////////////
                        Overridable Permissions
    //////////////////////////////////////////////////////////////*/

    /// @dev Checks whether an account has a particular role.
    function _hasRole(bytes32 _role, address _account) internal view returns (bool) {
        PermissionsStorage.Data storage data = PermissionsStorage.data();
        return data._hasRole[_role][_account];
    }

    /// @dev Returns whether all relevant permission and other checks are met before any upgrade.
    function _isAuthorizedCallToUpgrade() internal view virtual override returns (bool) {
        return _hasRole(EXTENSION_ROLE, msg.sender);
    }

    function _msgData() internal view override(Permissions) returns (bytes calldata) {
        return Permissions._msgData();
    }

    function _msgSender() internal view override(Permissions) returns (address sender) {
        return Permissions._msgSender();
    }




}