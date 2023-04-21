*Updated 21 April, 2023 · Toulouse*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

### Svija Synch App Icon

The app icon must be a transparent PNG image, given in the following sizes:

pixel size | margin | roundrect | Finder margin
----------:|-------:|----------:|-------------:
16         |      1 |       14  |           1
32         |      2 |       28  |           2
64         |      6 |       52  |           4
128        |     12 |      104  |           8
256        |     25 |      206  |          16
512        |     50 |      412  |          32
1024       |    100 |      824  |          64

When an app is selected in the Finder, there is an extra margin, ouside the icon (Finder margin).

For a 1024x1024 icon, the roundrect should have a 100px margin (be 824px square) centered.

There should be a shadow, and it should be **different at different sizes** (otherwise the shadow on small icon sizes looks too small).

See the [messages icon][mi] for an example of a "correct" icon.

[mi]: https://github.com/svijalove/sync/blob/beta/Interface/app%20icon/messages%20icon.png

---
### Colors

To keep the P3 color, Photoshop has to be configured (**cmd-shift-K** for color settings):

- Working Spaces › RGB: Display P3
- Color Management Policies › RGB: Convert to Working RGB
- Profile Mismatches: Ask When Opening 

Note that the shadow, rather than being black at 40% transparency, is 40% black at 100% transparency

---
### Official Colors

"Tennis" green/yellow:
- `#bbff00` as sRGB
- `#ccff00` as Display P3

Dark Gray:
- `#333`

In order to have the correct colors, the file is colored in Photoshop, not Illustrator.

---
### Drop Shadows

The drop shadows should be applied in Photoshop, so they will be first exported at the correct size without shadows from Illustrator.

roundrect | color | distance | size
---------:|:-----:|---------:|----:
1024 | #B0B0B0 | 10 | 25
32   | #B0B0B0 |  1 |  3


the sizes change slightly — the 32px icon has a 28px visible roundrect, not 26


changing screen resolution does not affect the size of the selected images in the finder
