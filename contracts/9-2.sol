// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface Living {
  function eat(string memory food) external returns (string memory);
}

contract HasName {
  string internal _name;

  constructor(string memory name) {
    _name = name;
  }
}

abstract contract Animal is Living {
  function eat(string memory food) pure virtual public returns (string memory) {
    return string(abi.encodePacked("Animal eats ", food));
  }

  function sleep() pure virtual public returns (string memory) {
    return "Z-z-z-z-z....";
  }

  function speak() pure virtual public returns (string memory) {
    return "...";
  }
}

abstract contract Herbivore is Animal, HasName {
  string constant PLANT = "plant";

  modifier eatOnlyPlant(string memory food) {
    require(keccak256(abi.encodePacked(food)) == keccak256(abi.encodePacked(PLANT)), "Can only eat plant food");
    _;
  }

  function eat(string memory food) pure virtual override public eatOnlyPlant(food) returns (string memory) {
    return super.eat(food);
  }
}

abstract contract Carnivore is Animal, HasName {
  string constant MEAT = "meat";

  modifier eatOnlyMeat(string memory food) {
    require(keccak256(abi.encodePacked(food)) == keccak256(abi.encodePacked(MEAT)), "Can only eat meat");
    _;
  }

  function eat(string memory food) pure virtual override public eatOnlyMeat(food) returns (string memory) {
    return super.eat(food);
  }
}

abstract contract Omnivore is Animal, HasName {
  string constant MEAT = "meat";
  string constant PLANT = "plant";

  modifier eatMeatOrPlant(string memory food) {
    require(keccak256(abi.encodePacked(food)) == keccak256(abi.encodePacked(MEAT)) || keccak256(abi.encodePacked(food)) == keccak256(abi.encodePacked(PLANT)), "Can eat meat or plant food");
    _;
  }

  function eat(string memory food) pure virtual override public eatMeatOrPlant(food) returns (string memory) {
    return super.eat(food);
  }
}

contract Cow is Herbivore {
  constructor(string memory name) HasName(name) {
  }

  function speak() pure override public returns (string memory) {
    return "Mooo";
  }
}

contract Horse is Herbivore {
  constructor(string memory name) HasName(name) {
  }

  function speak() pure override public returns (string memory) {
    return "Igogo";
  }
  function name() public view returns (string memory) {
    return _name;
  }
}

contract Dog is Omnivore {
  constructor(string memory name) HasName(name) {
  }

  function speak() pure override public returns (string memory) {
    return "Woof";
  }
  function name() public view returns (string memory) {
    return _name;
   }

}

contract Wolf is Carnivore {
  constructor(string memory name) HasName(name) {
  }

  function speak() pure override public returns (string memory) {
    return "Howl";
  }
}

contract Farmer {
  function isContract(address _addr) private view returns (bool isContract){
    uint32 size;
    assembly {
      size := extcodesize(_addr)
    }
    return (size > 0);
  }

  function feed(address animal, string memory food) pure public returns (string memory) {
    if (keccak256(abi.encodePacked(food)) == keccak256(abi.encodePacked("plant"))) {
      return Herbivore(animal).eat(food);
    } else if (keccak256(abi.encodePacked(food)) == keccak256(abi.encodePacked("meat"))) {
      return Carnivore(animal).eat(food);
    } else {
      revert("Can only feed animals with plant or meat");
    }
  }

  function call(address animal) view public returns (string memory){
    if (isContract(animal)) {
      return Animal(animal).speak();
    } else {
      revert("Address is not a contract");
    }
  }
}
