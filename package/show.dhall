let map =
      https://prelude.dhall-lang.org/v20.2.0/List/map.dhall
        sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let optional-map =
      https://prelude.dhall-lang.org/v20.2.0/Optional/map.dhall
        sha256:501534192d988218d43261c299cc1d1e0b13d25df388937add784778ab0054fa

let concatSep =
      https://prelude.dhall-lang.org/v20.2.0/Text/concatSep.dhall
        sha256:e4401d69918c61b92a4c0288f7d60a6560ca99726138ed8ebc58dca2cd205e58

let unpackOptionals =
      https://prelude.dhall-lang.org/v20.2.0/List/unpackOptionals.dhall
        sha256:0cbaa920f429cf7fc3907f8a9143203fe948883913560e6e1043223e6b3d05e4

let default =
      https://prelude.dhall-lang.org/v20.2.0/Optional/default.dhall
        sha256:5bd665b0d6605c374b3c4a7e2e2bd3b9c1e39323d41441149ed5e30d86e889ad

let Bib = ./bib.dhall

in  λ(entry : Bib.Type) →
      let keymaps = toMap entry

      let BibValue = Optional Text

      let MKV = { mapKey : Text, mapValue : BibValue }

      let maybe-show-field
          : MKV → Optional Text
          = λ(field : MKV) →
              optional-map
                Text
                Text
                (λ(v : Text) → "${field.mapKey} = {${v}}")
                field.mapValue

      let fields-showed =
            let maybe-fields = map MKV (Optional Text) maybe-show-field keymaps

            in  unpackOptionals Text maybe-fields

      let fields-showed-concatenated =
            concatSep
              ''
              ,
                ''
              fields-showed

      let type = default Text "error-missing-type" entry.type

      let ref = default Text "error-missing-ref" entry.ref

      in  ''
          @${type}{${ref},
            ${fields-showed-concatenated}
          }
          ''
