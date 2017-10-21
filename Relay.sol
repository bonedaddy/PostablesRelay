pragma solidity 0.4.18;

import './SafeMath.sol';
import './Administration.sol';

contract Relay is Administration {
    using SafeMath for uint256;

    address[] public targetContractList;

    struct WhiteListStruct {
        address targetContract;
        mapping (address => bool) allowed;
    }

    WhiteListStruct[] public whiteListArray;

    function Relay() {

    }

}