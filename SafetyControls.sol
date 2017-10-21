pragma solidity 0.4.18;

import './Administration.sol';

contract SafetyControls is Administration.sol {

    bool operationsPaused;

    event PauseOperation(address indexed _invoker, bool indexed _paused);
    event ResumeOperation(address indexed _invoker, bool indexed _resumed);

    function SafetyControls() {
        operationsPaused = true;
    }

    function pauseOperation()
        public
        onlyAdmins
        returns (bool _paused)
    {
        require(!operationsPaused);
        operationsPaused = true;
        PauseOperation(msg.sender, true);
        return true;
    }
    
    function resumeOperation()
        public
        onlyAdmins
        returns (bool _resumed)
    {
        require(operationsPaused);
        operationsPaused = false;
        ResumeOperation(msg.sender, true);
        return true;
    }

}