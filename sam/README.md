# SAM

*Software Automatic Mouth - Tiny Speech Synthesizer*

Compiled from [s-macke/SAM](https://github.com/s-macke/SAM/) with improvements from [RaafatTurki/SAM](https://github.com/RaafatTurki/SAM).

## Usage
You can run this on webassembly.sh, but there's not way to play the resulting wav files.

Try
```bash
wapm install liftm/sam
wapm run sam --dir=. -- -wav test.wav -phonetic \
  /HEHLOW FRAAM DHAX SAO4FTWEHR AA5RTIHFIHSHUL MAWTH Q
mpv test.wav
```
