[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

*Updated 1 October, 2021*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

# Svija Synch 1.0.3

There will be three versions:

- Svija Sync (App Store)
- Svija Sync Direct (direct download)
- Svija Sync Beta (for beta testing)

---

### Version Updates

Following are the instructions for releasing a new version of Svija Sync.

---
### 1. Merge to Master

Check out the **destination branch** and merge ([list of commits](https://github.com/svijalove/Svija-Tools/commits/beta)):
```
git status
```
```
git checkout master
git merge beta --no-ff
```
Push the new version:
```
git push origin master
```
---
### 2. Update the Documentation

Copy info from/to:

- [github.com/svijalove/django-svija/commits/master](https://github.com/svijalove/Svija-Tools/commits/master)
- [tech.svija.love/manual/changelog-sync](https://tech.svija.love/manual/changelog-sync)

---
### 3. Create a Notarized Version

Create an **notarized version** so that will be available in case of future compatibility problems.

---
### 4. Create A New Github Release

On github, create a new release from the **master branch**.

- use the current version number
- use the month & year for the title
- use the changelog text for the description

---
### 5. Check Out the Dev Branch

Commit any changes, then check out the beta branch:
```
git status
git commit -m "last commit before going back to beta" -a
```
Commit any changes, then check out the beta branch:
```
git checkout beta 
git merge master --no-ff -m "starting new version"
git push -u
```
---
### 6. Increment the Version Number

Places to update the version number:
- both Xcode targets
- this README.md
- msg.svija.love

---
### 8. Update tutorial content at tech.svija.com

Read through the [changelog](https://tech.svija.love/reference/changelogs/changelog-tools) and make a list of modfications for the new version.

Update the [documentation pages](https://tech.svija.com) if necessary.

---
### 7. Post to Social Media

Find a nice picture or make an ad to accompany the update, then

- [facebook.com/svijalove](https://facebook.com/svijalove)
- [twitter.com/svijalove](https://twitter.com/svijalove)
- [instagram/svijalove](https://instagram/svijalove) (make it 3x wide · has to be posted from phone)
- [linkedin.com/company/svijalove](https://linkedin.com/company/svijalove) (add text before adding image)

