[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

*Updated 27 August, 2021*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

# Svija Synch 1.0.2

There will be two versions:

- Svija Sync (App Store)
- Svija Sync Direct (direct download)

The message will be at an address that includes the app name.

The app name will be changed *after* notarization (if possible), so there will be no difference to users.

The only difference will be where the prefs are stored in the user's system (bundle ID).

---

The problem is that the app name is still visible in the About pane and as the name of the app menu.

---

### Version Updates

update the version in the newsView placeholder string

[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

*Updated 29 July, 2021*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

# DELETE THEME JSON FILES

---
---

# Releasing a New Version of Svija

**Simple version** — change to [detailed version](https://github.com/svijalove/Update-Svija-Admin/blob/master/detailed-version.md).

---

### 1. Database Backups

- **SSH** to all the servers to be updated
- update/create **sitelist.txt** with project folders:
```
vi sitelist.txt
```
- clone the **git repository**:
```
git clone ssh://git@github.com/svijalove/Update-Svija-Admin.git
chmod -R 777 Update-Svija-Admin
```
- run **backup-data.sh**:
```
Update-Svija-Admin/backup.sh
```
---

### 2. Linode Backups

Make [cloud backups](https://cloud.linode.com/linodes) at Linode.

---

### 3. Check for Migrations & Commit

Back on the **dev server**, do any final migrations:
```
cd /home/svijabeta
workon djangoEnv
./manage.py makemigrations
./manage.py migrate
```
In Svija Admin, check for unsaved changes and commit:
```
cd /opt/django-svija
git status
```
---
### 4. Merge to Master

Check out the **destination branch** and merge ([list of commits](https://github.com/svijalove/Svija-Admin/commits/dev)):
```
git checkout master
git merge dev --no-ff
```
Push the new version:
```
git push origin master
```
---
### 5. Update the Documentation

Copy info from/to:

- [github.com/svijalove/django-svija/commits/master](https://github.com/svijalove/Svija-Admin/commits/master)
- [tech.svija.love/manual/changelog-admin](https://tech.svija.love/manual/changelog-admin)

---
### 6. Create an Installable Version

Create an **installable version** so that will be available in case of future compatibility problems:

Run the tarball creation script:
```
cd /opt/django-svija
./save_tar.sh
```
---
### 7. Update the Svija Servers

Run the **update script:**
```
Update-Svija-Admin/update.sh
```
---
### 8. Update the Sync Message

If desired, SSH to the Svija Apache server to announce the changes:

---
### 9. Create A New Github Release

On github, create a new release from the **master branch**.

- use the current version number
- use the month & year for the title
- use the changelog text for the description

---
### 10. Check Out the Dev Branch

Commit any changes, then check out the dev branch:
```
git status
git commit -m "last commit before going back to dev" -a
```
Commit any changes, then check out the dev branch:
```
git checkout dev
git merge master --no-ff -m "starting new version"
git push -u
```
---
### Increment the Version Number

Places to update the version number:
```
cd /opt/django-svija
vi -O README.md setup.py save_tar.sh svija/views/__init__.py svija/templates/admin/base_site.html
```
Also in the **Update-Svija-Admin** repository (same as this document):
```
vi -O backup.sh update.sh # backup is new version -1
```
Then commit the version number change:
```
git commit -m "updated version number" -a && git push -u
```
---
### Post to Social Media

Find a nice picture or make an ad to accompany the update, then

- [facebook.com/svijalove](https://facebook.com/svijalove)
- [twitter.com/svijalove](https://twitter.com/svijalove)
- [instagram/svijalove](https://instagram/svijalove) (make it 3x wide · has to be posted from phone)
- [linkedin.com/company/svijalove](https://linkedin.com/company/svijalove) (add text before adding image)

---
### Update tutorial content at tech.svija.com

Read through the [changelog](https://tech.svija.love/reference/changelogs/changelog-admin) and make a list of modfications for the new version.

Update the [documentation pages](https://tech.svija.com) if necessary.

