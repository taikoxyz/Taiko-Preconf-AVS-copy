// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.25;

import {Script} from "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "openzeppelin-contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract BaseScript is Script {
    modifier broadcast() {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        require(privateKey != 0, "BaseSript: invalid private key");

        vm.startBroadcast();
        _;
        vm.stopBroadcast();
    }

    function deployProxy(address _impl, address _admin, bytes memory _data) internal returns (address) {
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(_impl, _admin, _data);
        return address(proxy);
    }
}
