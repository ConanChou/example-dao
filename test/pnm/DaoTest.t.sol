// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "contracts/Dao.sol";
import "@pwnednomore/contracts/Agent.sol";

contract DAOTest is Agent {
    DAO dao;

    address user = address(0x1);
    uint256 user_eth_amount = 1 ether;
    uint256 agent_eth_amount = 100000 wei;

    function setUp() external {
        dao = new DAO();

        hoax(user, user_eth_amount);
        dao.deposit{value: user_eth_amount}(user);

        hoax(address(this), agent_eth_amount);
        dao.deposit{value: agent_eth_amount}(address(this));
    }

    function invariantBalanceLowerLimit() external {
        // INVARAINT:
        // The vault should always have at least 1 ether.
        // Otherwise, user cannot get the fund back.
        assert(address(dao).balance >= 1 ether);
    }
}
