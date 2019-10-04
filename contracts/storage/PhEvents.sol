pragma solidity ^0.5.0;


contract PhEvents {

    event AddReputation (
        uint256 tokenId,
        uint256 reputationCount
    );

    event ExampleEvent (
        uint exampleId,
        string exampleName,
        address exampleAddr
    );

}
