open Chakra
open UseDApp

@val @scope("window") @uncurry
external openWindow: string => unit = "open"

let onError = error => Js.log(error)

@react.component
let make = () => {
  let {activateBrowserWallet, account} = useEthers()
  let etherBalance = useEtherBalance(account)

  let handleConnectWallet = () => activateBrowserWallet(~throwErrors=None, ~onError)

  let etherBalanceValue = switch etherBalance {
  | Some(balance) =>
    balance
    ->formatEther
    ->Js.Float.fromString
    ->Js.Float.toFixedWithPrecision(~digits=3)
    ->Js.String2.concat(" ETH")
  | None => "Loading Value..."
  }

  switch account {
  | Some(_) =>
    <Box display=#flex alignItems=#center backgroundColor=#gray700 borderRadius=#xl py=#px(1)>
      <Box px=#three>
        <Text color=#white fontSize=#md> {etherBalanceValue->React.string} </Text>
      </Box>
      <Button
        backgroundColor=#gray800
        border=#border(#px(1), #solid, #transparent)
        _hover={pseudo(
          ~border=#border(#px(1), #solid, #blue400),
          ~backgroundColor=#gray700,
          ~color=#teal500,
          (),
        )}
        borderRadius=#xl
        m=#px(1)
        px=#three
        height=#px(38)
        onClick={_ =>
          openWindow(
            "https://ropsten.etherscan.io/address/0x95c00D51e055cf786622e293cca780A92dD179b2",
          )}>
        <Text color=#white fontSize=#md fontWeight=#medium mr=#two>
          {switch account {
          | Some(account) =>
            account
            ->Js.String.slice(~from=0, ~to_=6)
            ->Js.String2.concat("...")
            ->Js.String2.concat(
              Js.String2.slice(
                ~from=Js.String.length(account) - 4,
                ~to_=Js.String.length(account),
                account,
              ),
            )
            ->React.string
          | None => "No account"->React.string
          }}
        </Text>
        <Identicon />
      </Button>
    </Box>
  | None =>
    <Button colorScheme=#orange onClick={_ => handleConnectWallet()}>
      {React.string("Connect Wallet")}
    </Button>
  }
}
