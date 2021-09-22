let dhall-bibtex =
      https://raw.githubusercontent.com/alejandrogallo/dhall-bibtex/master/package/package.dhall
        sha256:fb04b24f13f5f05b7768b0ad00ef2b9453aa0afd32938e66bd1dcd350e16b3ce

let Bib = dhall-bibtex.Bib

let map =
      https://prelude.dhall-lang.org/v20.2.0/List/map.dhall
        sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let concatSep =
      https://prelude.dhall-lang.org/v20.2.0/Text/concatSep.dhall
        sha256:e4401d69918c61b92a4c0288f7d60a6560ca99726138ed8ebc58dca2cd205e58

let entries
    : List Bib.Type
    = env:DHALL_TO_BIBTEX_ENTRIES

in  concatSep "\n" (map Bib.Type Text dhall-bibtex.show entries)
