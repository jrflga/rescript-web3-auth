type useEthers = {
  activateBrowserWallet: (~throwErrors: option<bool>, ~onError: option<()> => ()) => (),
  account: option<string>,
  chainId: int
}

module DAppProvider = {
  @react.component @module("@usedapp/core")
  external make: (~children: React.element) => React.element = "DAppProvider"
}

@module("@usedapp/core")
external useEthers: () => useEthers = "useEthers"

@module("@usedapp/core")
external useEtherBalance: option<string> => 'a = "useEtherBalance"

@module("@ethersproject/units")
external formatEther: 'a => string = "formatEther"
