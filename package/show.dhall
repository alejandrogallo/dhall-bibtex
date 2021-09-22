let map =
      https://prelude.dhall-lang.org/v20.2.0/List/map.dhall
        sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let concatSep =
      https://prelude.dhall-lang.org/v20.2.0/Text/concatSep.dhall
        sha256:e4401d69918c61b92a4c0288f7d60a6560ca99726138ed8ebc58dca2cd205e58

let Bib = ./bib.dhall

in  λ(entry : Bib.Type) →
      let keymaps = toMap entry

      let BibValue = Optional Text

      let MKV = { mapKey : Text, mapValue : BibValue }

      let show-field =
            λ(field : MKV) →
              merge
                { None = ""
                , Some = λ(value : Text) → "${field.mapKey} = {${value}}"
                }
                field.mapValue

      let fields-showed = map MKV Text show-field keymaps

      let fields-showed-concatenated =
            concatSep
              ''
              ,
                ''
              fields-showed

      in  ''
          @article{ref,
            ${fields-showed-concatenated}
          }
          ''
