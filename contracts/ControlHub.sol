pragma solidity 0.4.18;

import './modules/SafeMath.sol';
import './modules/Administration.sol';

contract ControlHub is Administration {
    using SafeMath for uint256;

    address[]   public  targetContractList;
    uint256     public  numContractsRegistered;
    bool        public  contractLaunched;

    struct WhiteListStruct {
        address contractAddress;
        mapping (address => bool) allowed;
    }

    WhiteListStruct[] public whiteListArray;

    mapping (address => uint256) public whiteListArrayId;
    mapping (address => address) public contractSubmitter;

    event ContractRegistered(address indexed _submitter, address indexed _targetContract, bool indexed _registered);


    modifier preLaunch() {
        require(!contractLaunched);
        _;
    }

    modifier postLaunch() {
        require(contractLaunched);
        _;
    }

    function Relay() public {
        contractLaunched = false;
        numContractsRegistered = 0;
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

    function addContract(address _contract)
        public
        postLaunch
        returns (bool _added)
    {
        require(_contract != address(0x0));
        WhiteListStruct memory w;
        w.contractAddress = _contract;
        whiteListArray.push(w);
        targetContractList.push(_contract);
        whiteListArrayId[_contract] = numContractsRegistered;
        numContractsRegistered = numContractsRegistered.add(1);
        contractSubmitter[_contract] = msg.sender;
        return true;
    }

    function whiteListAddress(address _whiteListedAddress, address _targetContract)
        public
        postLaunch
        returns (bool _whiteListed)
    {
        require(contractSubmitter[_targetContract] == msg.sender);
        uint256 _id = whiteListArrayId[_targetContract];
        whiteListArray[_id].allowed[_whiteListedAddress] = true;
        return true;
    }

    function callAddress(address _targetContract, string _functionSign,  string _argValues)
        public
        returns (bool _success)
    {
        require(_targetContract.call(bytes4(keccak256(_functionSign)), _argValues));
        return true;
    }

    function IntSet(address _targetContract, uint256 _newInt)
        public
        returns (bool _success)
    {
        require(_targetContract.call(bytes4(keccak256("setInt(uint256)")), _newInt));
        return true;
    }
}