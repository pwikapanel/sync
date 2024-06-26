
*Updated 10 October, 2023 · Toulouse*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

### Svija Synch 1.0.7

There are three versions:

- **Svija Sync** · Mac App Store
- **Svija Sync Direct** · direct download
- **Svija Sync Direct Beta** · beta testing

They are determined in Xcode through choosing a **schemes** under the **Product menu**.

----------------------------------------

Passwords have just been expanded to allow:
- accented characters
- `!"#$%&'()*+,-./:;<=>?@[\]^_\`{|}~£€¥`


*Updated 10 October, 2023 · Toulouse*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

### Svija Synch 1.0.7

There are three versions:

- **Svija Sync** · Mac App Store
- **Svija Sync Direct** · direct download
- **Svija Sync Direct Beta** · beta testing

They are determined in Xcode through choosing a **schemes** under the **Product menu**.

----------------------------------------

### 240626 notes

1. replaced all occurences of /sync/ with /SYNC/
2. in Xcode, click on folder in left column, then first element (SvijaSync)
3. click `Build Phases` in middle section
4. notice that Svija Sync has two `Link Binary With Libraries` whereas Svija Sync Beta has only one
5. the missing binary is SwiftyBeaver
6. click `Svija Sync Beta` at left, then add SwiftyBeaver to the linked binaries
7. change scheme to `beta`, and the app should now build (▶)

---
### Update the version number

The previous publicly-released version was 1.0.8, so this will be 1.0.9

1. in the left column, click each target
2. change version to 1.0.9

---
### Update AppDelegate.swift

I don't remember why, but it was necessary to uncheck all but one of the boxes.

1. click on AppDelegate.swift in the left column
2. uncheck all but `Svija Sync Beta` at right

in left column find Utility/Rsync/Binaries/Rsync-debug and check the desired target membership at right
