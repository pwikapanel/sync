
*Updated 18 December, 2025 · Toulouse*

![Pwika: SVG-based websites built in Adobe Illustrator][logo]

[logo]: http://files.pwika.com/github/github_banner.png "Pwika: SVG-based websites built in Adobe Illustrator"

### Pwika Synch 1.0.7

There are three versions:

- **Pwika Sync Direct** · direct download
- **Pwika Sync Direct Beta** · beta testing

They are determined in Xcode through choosing a **schemes** under the **Product menu**.

----------------------------------------

Passwords have just been expanded to allow:
- accented characters
- `!"#$%&'()*+,-./:;<=>?@[\]^_\`{|}~£€¥`

----------------------------------------

### 240626 notes

1. replaced all occurences of /sync/ with /SYNC/
2. in Xcode, click on folder in left column, then first element (PwikaSync)
3. click `Build Phases` in middle section
4. notice that Pwika Sync has two `Link Binary With Libraries` whereas Pwika Sync Beta has only one
5. the missing binary is SwiftyBeaver
6. click `Pwika Sync Beta` at left, then add SwiftyBeaver to the linked binaries
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
2. uncheck all but `Pwika Sync Beta` at right

in left column find Utility/Rsync/Binaries/Rsync-debug and check the desired target membership at right
