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
