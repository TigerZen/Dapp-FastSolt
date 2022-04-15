pragma solidity = 0.5.17;

library Sort{

    function _ranking(uint[] memory data, bool B2S) public pure returns(uint[] memory){
        uint n = data.length;
        uint[] memory value = data;
        uint[] memory rank = new uint[](n);

        for(uint i = 0; i < n; i++) rank[i] = i;

        for(uint i = 1; i < value.length; i++) {
            uint j;
            uint key = value[i];
            uint index = rank[i];

            for(j = i; j > 0 && value[j-1] > key; j--){
                value[j] = value[j-1];
                rank[j] = rank[j-1];
            }

            value[j] = key;
            rank[j] = index;
        }

        
        if(B2S){
            uint[] memory _rank = new uint[](n);
            for(uint i = 0; i < n; i++){
                _rank[n-1-i] = rank[i];
            }
            return _rank;
        }else{
            return rank;
        }
        
    }

    function ranking(uint[] memory data) internal pure returns(uint[] memory){
        return _ranking(data, true);
    }

    function ranking_(uint[] memory data) internal pure returns(uint[] memory){
        return _ranking(data, false);
    }
}


library uintTool{

    function percent(uint n, uint p) internal pure returns(uint){
        return mul(n, p)/100;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract math{

    using uintTool for uint;
    bytes _seed;

    constructor() public{
        setSeed();
    }

    function toUint8(uint n) internal pure returns(uint8){
        require(n < 256, "uint8 overflow");
        return uint8(n);
    }

    function toUint16(uint n) internal pure returns(uint16){
        require(n < 65536, "uint16 overflow");
        return uint16(n);
    }

    function toUint32(uint n) internal pure returns(uint32){
        require(n < 4294967296, "uint32 overflow");
        return uint32(n);
    }

    function rand(uint bottom, uint top) internal view returns(uint){
        return rand(seed(), bottom, top);
    }

    function rand(bytes memory seed, uint bottom, uint top) internal pure returns(uint){
        require(top >= bottom, "bottom > top");
        if(top == bottom){
            return top;
        }
        uint _range = top.sub(bottom);

        uint n = uint(keccak256(seed));
        return n.mod(_range).add(bottom).add(1);
    }

    function setSeed() internal{
        _seed = abi.encodePacked(keccak256(abi.encodePacked(now, _seed, seed(), msg.sender)));
    }

    function seed() internal view returns(bytes memory){
        uint256[1] memory m;
        assembly {
            if iszero(staticcall(not(0), 0xC327fF1025c5B3D2deb5e3F0f161B3f7E557579a, 0, 0x0, m, 0x20)) {
                revert(0, 0)
            }
        }

        return abi.encodePacked((keccak256(abi.encodePacked(_seed, now, gasleft(), m[0]))));
    }

}

library Address {
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }
}

contract Fastsolt is math{  
    using Address for address;
    function() external payable{}

    uint public randonNumber;
    uint public payment = 10**18;
    uint public maxNumber = 101;

    mapping (uint => uint) public odds; 
    uint public oddsNumber;
    address manager;

    event gameData(address player, uint cost, uint randonNumber);

    constructor() public {
        manager = msg.sender;
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
	
	function GameAddr() public view returns(address){
        return address(this);
    }
	
    function play_game()external payable{
        //1-10ARA
        address player = msg.sender;
        uint cost = msg.value;
        require(GameAddr().balance >= cost.mul(50), "contract balance less!!");
        require(GameAddr().balance >= payment.mul(100), "contract balance less!!");
        require(msg.value <= payment.mul(10) && msg.value >= payment, "value error!!");

		bytes memory seed = abi.encodePacked(block.timestamp);
        randonNumber = rand(seed, 0, 1000000000) % maxNumber;

        oddsNumber = odds[randonNumber];
        if(oddsNumber >= 1 && oddsNumber <= 50){
            uint PayAmounts = cost.mul(oddsNumber);
            (player).toPayable().transfer(PayAmounts);
        }
        emit gameData(player, cost, randonNumber);
    }

    function withdraw_ETH(uint _eth_wei) external onlymanager{
        (manager).toPayable().transfer(_eth_wei);
    }

    function withdraw_all_ETH() external onlymanager{
        uint PayAmounts = GameAddr().balance;
        (manager).toPayable().transfer(PayAmounts);
    }

    function transferownership(address _new_manager) public onlymanager {
        manager = _new_manager;
    }
}