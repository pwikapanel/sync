*Updated 21 April, 2023 · Toulouse*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

### Svija Synch App Icon

The app is designed in Illustrator in **black and white**, without the transparent margin outside the roundrect.

In Photoshop the **color**, **margin** and **drop shadow** are added.

This is because Photoshop permits batch saving PNG images with the **Display P3** color profile attached, and Illustrator does not.

The app icon is a transparent PNG image created at the following sizes:

pixel size | margin | roundrect | Finder margin
----------:|-------:|----------:|-------------:
16         |      1 |       14  |           1
32         |      2 |       28  |           2
64         |      6 |       52  |           4
128        |     12 |      104  |           8
256        |     25 |      206  |          16
512        |     50 |      412  |          32
1024       |    100 |      824  |          64

**Finder margin**: when an app is selected in the Finder, there is an extra gray margin, ouside the icon.

See the included [messages icon][mi] for an example of a "correct" icon.

[mi]: https://github.com/svijalove/sync/blob/beta/Interface/app%20icon/messages%20icon.png

---
### Finder Notes

The Finder adds additional scaling steps in addition to the above pixel sizes:

- 155px & 40px roundrects

Changing screen resolution does not affect the size of the selected images in the finder.

---
### Official Colors

"Tennis" green/yellow:
- `#bbff00` in sRGB
- `#ccff00` in Display P3

Dark Gray:
- `#333`

---
### Colors

To preserve the rich **Display P3** color, Photoshop has to be configured (**cmd-shift-K** for color settings):

- Working Spaces › RGB: **Display P3**
- Color Management Policies › RGB: **Convert to Working RGB**
- Profile Mismatches: **Ask When Opening** 

---
### Drop Shadows

Shadows are **different at different sizes** (otherwise the shadow on small icon sizes looks too small).

The drop shadows are applied in Photoshop:

roundrect |  transp | distance | size
---------:|:-------:|---------:|----:
824       |   30%   |    10    | 25
412       |   30%   |     5    | 12
206       |   30%   |     3    |  6
104       |   30%   |     1    |  3
52        |   30%   |     1    |  3
28        |   30%   |     1    |  2
14        |   30%   |     1    |  1

Note: gray drop shadows do not work on the dark background of Launchpad —  they must be **black and transparent**.

---
### Photoshop Slices

The slice tools are under the **crop tool**.

Double-click a slice with the **Slice Select** tool to set the size manually — it's much faster.

You can click on empty areas and change the slice time to "No Image" to avoid creating extra images

Note that **in the save for web** dialog you have to use the Slice Select tool and choose PNG. You can just drag to select all (cmd-A doesn't work).

Saving with slices saves to a subfolder called **images** in the selected folder.

---
### Installing the Icon

Click on the **folder icon** in the top left corner of the Xcode window.

Choose **Assets.xcassets** in the second-level **SvijaSync** folder.

**Double click each icon** to replace it — pay attention to the pixel size in the breadcrumb links above.

