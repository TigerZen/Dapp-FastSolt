pragma solidity ^0.4.25;

contract Fastsolt {    
    //1~100
    uint public randonNumber;
    uint public payment = 10**18;
    uint public maxNumber = 101;

    // //test
    // uint public payment = 10**16;
    // uint public maxNumber = 30;

    mapping (uint => uint) public odds; 
    uint public oddsNumber;
    uint public balance;
    address manager;

    event gameData(address player, uint cost, uint randonNumber);

    constructor() public payable{
        manager = msg.sender;
        balance = address(this).balance;
        odds[0] = 50;
        odds[1] = 20;
        odds[2] = 10;
        odds[3] = 8;
        odds[4] = 5;
        odds[5] = 3;
        odds[6] = 2;
        odds[7] = 2;
        odds[8] = 2;
        odds[9] = 2;
        odds[10] = 2;
        odds[11] = 1;
        odds[12] = 1;
        odds[13] = 1;
        odds[14] = 1;
        odds[15] = 1;
        odds[16] = 1;
        odds[17] = 1;
        odds[18] = 1;
        odds[19] = 1;
        odds[20] = 1;
    }

    modifier onlymanager{
        require(msg.sender == manager);
        _;
    }
    
    function()public payable{}
    
    function play_game()public payable{
        //1-10TAN
        address player = msg.sender;
        uint cost = msg.value;
        require(address(this).balance>=50*cost, "contract balance less!!");
        require(address(this).balance>=100*payment, "contract balance less!!");
        require(msg.value <= payment*10 && msg.value >= payment, "value error!!");
        randonNumber = rand()%maxNumber;

        oddsNumber = odds[randonNumber];
        if(oddsNumber >= 1 && oddsNumber <= 50){
            player.transfer(cost * oddsNumber);
        }
        balance = address(this).balance;
        emit gameData(player, cost, randonNumber);
    }

    function rand() public returns (uint256) {
        uint256[1] memory m;
        assembly {
            if iszero(staticcall(not(0), 0xC327fF1025c5B3D2deb5e3F0f161B3f7E557579a, 0, 0x0, m, 0x20)) {
                revert(0, 0)
            }
        }
        return m[0];
    }

    function withdraw_ETH(uint _eth_wei) public onlymanager{
        manager.transfer(_eth_wei);
    }

    function withdraw_all_ETH() public onlymanager{
        manager.transfer(address(this).balance);
    }

    function transferownership(address _new_manager) public onlymanager {
        manager = _new_manager;
    }
}