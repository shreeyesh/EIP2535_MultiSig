# EIP2535_MultiSig

		EIP 2535 - Diamond Standard: MultiSig Wallet 

https://github.com/shreeyesh/EIP2535_MultiSig


The Diamond Standard is an improvement over EIP-1538. It has the same idea: To map single functions for a delegatecall to addresses, instead of proxying a whole contract through.

The important part of the Diamond Standard is the way storage works. Unlike the unstructured storage pattern that OpenZeppelin uses, the Diamond Storage is putting a single struct to a specific storage slot.

Simple Summary
The standard for creating modular smart contract systems that can be extended after deployment.
Enables people to write smart contracts with virtually no size limit.
Diamonds can be upgraded without having to redeploy existing functionality. Parts of a diamond can be added/replaced/removed while leaving other parts alone.
Standardizes contract interfaces and implementation details of diamonds, enabling software integration and interoperability.
A diamond is a contract that implements the Specification in this standard.
Diamond analogy helps conceptualize development.
 
Checkout basics about diamond standard: 
https://eips.ethereum.org/EIPS/eip-2535#simple-summary
https://soliditydeveloper.com/eip-2535/

Libraries can do the following:
code organization, yes libraries allow this
modularity, yes
fine grained upgrades, libraries and/ or contract can be upgraded with OZ but maybe not to the degree of Diamond
reusable on-chain code, the main reason libraries exist
But not these:
smart contract protocol extension,
stable address without a limit of the number of external functions.
 
 
Links i’d recommend to go through :
https://dev.to/mudgen/understanding-diamonds-on-ethereum-1fb
https://hiddentao.com/archives/2020/05/28/upgradeable-smart-contracts-using-diamond-standard
https://github.com/lampshade9909/DiamondSetter
https://eip2535diamonds.substack.com/p/understanding-delegatecall-and-how
 
Future Goals regarding Open-Protocol for mainnet :
We can look towards optimizing diamondcut , you can checkout this https://github.com/mudgen/diamond-2-hardhat which is pretty gas optimized but on the same time quite complicated. Another suggestion is creating a sandbox environment using scaffold-eth (https://github.com/scaffold-eth/scaffold-eth/tree/diamond-standard)
We can also aid with the help of Diamond Setter(https://github.com/lampshade9909/DiamondSetter), such that we can make things easier and safer when it comes to diamond upgradeability.
 
Also checkout the list of projects using diamond standard https://eip2535diamonds.substack.com/p/list-of-projects-using-eip-2535-diamonds
 
 

