pragma solidity 0.4.18;

import './SafeMath.sol';
import './Administration.sol';

contract VariableSetter is Administration {
    using SafeMath for uint256;

    bool contractLaunched;
}