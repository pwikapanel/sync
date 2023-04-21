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
### Finder Notes

The Finder adds a margin beyond the icon when it's selected (see chart above).

The Finder adds additional scaling steps in addition to the above pixel sizes:

- 155px & 40px roundrects

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

roundrect |  color  | distance | size
---------:|:-------:|---------:|----:
824       | #b0b0b0 |    10    | 25
412       | #b0b0b0 |     5    | 13
206       | #b0b0b0 |     3    |  7
104       | #b0b0b0 |     2    |  5
52        | #b0b0b0 |     1    |  4
28        | #b0b0b0 |     1    |  3
14        | #b0b0b0 |     1    |  1

the sizes change slightly — the 32px icon has a 28px visible roundrect, not 26


changing screen resolution does not affect the size of the selected images in the finder

---
### Photoshop Slices

The slice tools are under the **crop tool**.

Double-click a slice with the **Slice Select** tool to set the size manually — it's much faster.

You can click on empty areas and change the slice time to "No Image" to avoid creating extra images

Note that you have to use the Slice Select tool and choose PNG **in the save for web** dialog. You can just drag to select all (cmd-A doesn't work).

Saving with slices will automatically create a folder called **images**.
