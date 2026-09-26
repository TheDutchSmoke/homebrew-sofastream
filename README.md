# SofaStream Homebrew tap

One tap for stable SofaStream and the @dev channel.

```sh
brew install TheDutchSmoke/sofastream/sofastream
brew install TheDutchSmoke/sofastream/sofastream@dev
```

Run stable with `tv` and development with `tv-dev` (also `sofastream@dev`).
Both can be installed side by side, with separate settings and stream processes.
`@dev` is an alias to the internal preview formula because Homebrew formula class
names only support numeric versions after `@`.

```sh
brew update
brew upgrade sofastream@dev
```

Source and release notes: https://github.com/TheDutchSmoke/sofastream

Installing, upgrading and the formula tests do not contact an Apple TV.
Use VLC Remote Playback on your Apple TV. Pairing (`tv pair` / `tv-dev pair`)
displays a PIN and should only be run when the TV is available.
