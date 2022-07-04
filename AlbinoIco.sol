//SPDX-license-identifier: MIT
pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/AllowanceCrowdsale.sol";

contract ROGCrowdSale is Crowdsale, AllowanceCrowdsale {

    uint256 private minPurchase;
    uint256 private _rate;
    uint256 private decimals;

    constructor(
        uint256 rate,
        address payable wallet,
        IERC20 token,
        address tokenWallet,  // <- new argument
        uint256 _minPurchase, 
        uint256 _decimals
    )
        AllowanceCrowdsale(tokenWallet)  // <- used here
        Crowdsale(rate, wallet, token)
        public
    {
        minPurchase = _minPurchase;
        _rate = rate;
        decimals = _decimals;
    }

    function _getTokenAmount(uint256 weiAmount) internal view returns (uint256) {
        uint256 tokenPrice = 216666667000000000;
        uint256 token = 10 ** 18;
        return (token.div(tokenPrice).mul(weiAmount));
    }

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view {
        require(beneficiary != address(0), "Crowdsale: beneficiary is the zero address");
        require(weiAmount != 0, "Crowdsale: weiAmount is 0");
        require(weiAmount % minPurchase == 0, "Invalid Amount");
        this;
    }


}