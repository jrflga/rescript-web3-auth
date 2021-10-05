module Layout = {
  open Chakra
  @react.component
  let make = (~children: option<React.element>=?) =>
    <Flex
      flexDirection=#column
      alignItems=#center
      justifyContent=#center
      height=#vh(100.0)
      backgroundColor=#gray800>
      <Box
        display=#flex
        flexDirection=#column
        alignItems=#center
        justifyContent=#center
        height=#xl2
        width=#xl4
        backgroundColor=#gray600
        p=#ten
        borderRadius=#md>
        {switch children {
        | Some(element) => element
        | None => React.null
        }}
      </Box>
    </Flex>
}

module App = {
  @react.component
  let make = () => {
    <UseDApp.DAppProvider>
      <Chakra.Provider>
        <Layout>
          <Wallet />
        </Layout>
      </Chakra.Provider>
    </UseDApp.DAppProvider>
  }
}

switch ReactDOM.querySelector("#app-root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => ()
}
