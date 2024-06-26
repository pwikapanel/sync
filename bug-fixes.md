
*Updated 2 April, 2024 · Toulouse*

![Svija: SVG-based websites built in Adobe Illustrator][logo]

[logo]: http://files.svija.love/github/readme-logo.png "Svija: SVG-based websites built in Adobe Illustrator"

### Bug Fixes

can't upload to ovnius. There are two error messages:
```
++@ERROR: Unknown module 'ovnius211103'
```
and
```
rsync error: error starting client-server protocol (code 5) at /System/Volumes/Data/SWE/macOS/BuildRoots/533514bb11/Library/Caches/com.apple.xbs/Sources/rsync/rsync-55/rsync/main.c(1402) [receiver=2.6.9]
```
It's able to tell me that site creator has modified the site, so rsyncd is working to get the .last file.

Probably a permissions problem.

Replaced sync folder with svija.love sync folder, didn't change anything, but of course it wouldn't because the ownership is wrong

I'll do the rest of the sites and see if there are any issues.

---

Can't upload to svija.dev after replacing contents with svija.love.

- deleting hidden .un~ files in local sync folder didn't help

**Fix:** removing **replace-site** from server-side sync folder cured the problem (there were two hidden files in it, .git & .gitignore).

---

Couldn't upload to svija.dev

The fix was:
- start the rsync daemon by typing `sudo rsync --daemon` 
- change user permissions to 777 with `chmod -R 777 /home/svijadev/sync`

`sudo rsync --daemon` worked again (230210), without changing permissions.

Used both fixes together (230227) to fix ovnius couldn't download

---

Couldn't upload to example.svija.site, so I tried the above steps to no avail.

The correct permissions for /sync are 755

What worked was downloading first — possibly a missing .last file?

---

next time I modify this page, create a new issue and consolidate all into one page.

Leave a big note at the top that each time it's updated it should be copied/closed.

---

simply restarting rsync fixed latest problem:
```
service rsync restart
```
