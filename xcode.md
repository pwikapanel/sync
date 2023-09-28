thsese are notes about how to set up a new development environment.

1. download Xcode from App Store (or developer.apple.com if it's a beta)

*note: can't use regular Xcode on beta system*

2. the package dependency will fail at first because you're not connected to Github

- settings › accounts + Github

---

on github:

profile › settings › developer settings (last) › Personal access tokens

check:
- repo
- admin:public_key
- user
- write:discussion

---

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

on mac:

create ssh key
```
ssh-keygen -t ed25519 -C "andy@svija.com"
```
open the .pub version and paste it into github settings

---

### build failed

No signing entity.

in Xcode, click on the top level of the hierarchy in the left panel, then choose a target (Svija Sync Beta).

In the top tabs, choose "Signing & Capabilities"

Under Team, choose "Add an Account"

**this could be done in Xcode preferences**

sign in with tech@svija.com

---
### build failed

Need to agree to latest agreement in Apple Dev account

developer.apple.com

done.

---
### build failed

No signing certificate Z66QVF9XBZ with a private key was found

the provisionprofile is in repo sync/Code Signing/Provisioning Profile

just open with Xcode (right-click)

---
### build failes

No access to sync-rsync repo

top level of hierarchy in Xcode › project SvijaSync › Package Dependencies

delete all pagckaes, add local (after having downloaded repo)

---
### the error

execv(/usr/libexec/rsync/rsync.samba): Operation not permitted

https://developer.apple.com/forums/thread/126497
"This is a consequence of new user privacy protections in macOS 10.15. See WWDC 2019 Session 701 Advances in macOS Security for all the details. As a user, you can grant access to the tool by adding it to the list in System Preferences > Security & Privacy > Privacy > Files and Folders."


