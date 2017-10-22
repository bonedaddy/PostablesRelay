pragma solidity 0.4.18;

import './SafeMath.sol';
import './Administration.sol';
import './SafetyControls.sol';

contract VariableSetter is SafetyControls {
    using SafeMath for uint256;

    bool contractLaunched;

    modifier preLaunch() {
        require(!contractLaunched);
        _;
    }

    function VariableSetter() {
        contractLaunched = false;
    }

    function launchContract()
        public
        preLaunch
        onlyAdmin
        returns (bool _launched)
    {
        contractLaunched = true;
        return true;
    }

    functi
}