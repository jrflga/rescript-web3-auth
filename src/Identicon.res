open UseDApp

type generateIdenticon = {
  diameter: int,
  seed: int
}

@module external jazzicon: (~diameter: int, ~seed: int) => Dom.element = "@metamask/jazzicon"
@val external parseInt: (~string: string, ~base: int) => int = "parseInt"
@send external appendChild: (Dom.element, Dom.element) => unit = "appendChild"

@react.component
let make = () => {
  let iconRef = React.useRef(Js.Nullable.null)
  let {account} = useEthers()

  let accountSeed = switch account {
  | Some(account) => parseInt(~string=Js.String2.slice(account, ~from=2, ~to_=10), ~base=16)
  | None => 0
  }

  React.useEffect1(() => {
    switch (account, iconRef.current->Js.Nullable.toOption) {
    | (Some(_), Some(dom)) => dom->appendChild(jazzicon(~diameter=16, ~seed=accountSeed))
    | (_, _) => ()
    }
    None
  }, [])

  <div
    className={Emotion.css({
      "height": "1rem",
      "width": "1rem",
      "borderRadius": "1.125rem",
      "backgroundColor": "black",
    })}
    ref={ReactDOM.Ref.domRef(iconRef)}
  >
  </div>
}
