//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create{
    using Counters for Counters.Counter;

    Counters.Counter public _voterId;
    Counters.Counter public _candidateId;

    address public votingOrganizer;
    
    //CANDIDATE FOR VOTING
    struct Candidate{
        uint256 candidateId;
        string age;
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs;
    }

    event CandidateCreate (
         uint256 indexed candidateId,
        string age,
        string name,
        string image,
        uint256 voteCount,
        address _address,
        string ipfs
    ) ; 

    address[] public candidateAddress;

    mapping(address => Candidate) public candidates;

    //////END OF CANDIDATE DATA

    //-------------VOTER DATA

    address[] public voteVoters;

    address[] public votersAddress;
    mapping(address => voter) public voters;

    struct voter{
        uint256 voter_voterId;
        string voter_name;
        string voter_image;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;
    }

    event VoterCreated(
        uint256 indexed voter_voterId,
        string voter_name,
        string voter_image,
        address voter_address,
        uint256 voter_allowed,
        bool voter_voted,
        uint256 voter_vote,
        string voter_ipfs
    );

    // ----------END OF VOTER DATA

    constructor (){
        votingOrganizer = msg.sender;
    }

    function setCandidate(address _address, string memory _age, string memory _name, string memory _image, string memory _ipfs)public{
        require(votingOrganizer == msg.sender, "Only organizer can create a candidate ");

        _candidateId.increment();

        uint256 idNumber = _candidateId.current();

        Candidate storage candidate = candidates[_address];

        candidate.age = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddress.push(_address);

    }

}