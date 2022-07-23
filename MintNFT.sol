

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; //형변환하기 위해 import 해줘야할것.

contract MintNFT is ERC721Enumerable, Ownable {
    
    string public metadataURI;

    constructor(string memory _name, string memory _symbol, string memory _metadataURI) ERC721(_name, _symbol) {
        metadataURI = _metadataURI;
    }
    //이 스마트 컨트렉이 배포된 시점에 1번 실행되는 함수
    //배포되는 시점에 이름과 티커를 입력받기위해 string memory _name, string memory 라고 쓴다.
    //constructor는 배포 시기에 한번만 실행되는 함수이기 때문에 onlyOwner 의 속성이 필요가 없다.

    function mintNFT() public {     //functiona 함수면(입력값) 샐행권한 {실행내용}

        require(totalSupply()<10,"You can no longer mint NFT");

        uint tokenId = totalSupply() + 1; //uint 양수 타입 , totalSupply()는 ERC에 있는 함수로써 발행된 NFT의 총량을 나타낸다.

        _mint(msg.sender, tokenId); //_mint(NFT 발생자, NFT 고유번호)
    }

    function batchMintNFT(uint _amount) public {
        for(uint i = 0 ; i< _amount ; i++){
            mintNFT();
        }
    }

    function tokenURI(uint _tokenId) override public view returns (string memory) {
        return string(abi.encodePacked(metadataURI,'/',Strings.toString(_tokenId),'.json'));        //(https://gateway.pinata.cloud/ipfs/[CID]/3.json) 
    }

} //ERC721 표준 타입을 상속해서 써준다.

