Xcode build failed because it couldn't find the Rsync package.

It turns out that in the main view, under targets, all the targets had it listed except Svija Sync (app store version).

---

while submitting to Apple, I got the following error:

This bundle is invalid.

The value for key CFBundleVersion [12] in the Info.plist file must contain a higher version than that of the previously uploaded version [13].

Please find more information about CFBundleVersion at https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleversion (ID: 05af89ef-778b-4bad-92ee-d96af1ccd3bd)

I had to manually update the location of Svija Sync copy-info.plist using the file inspector (it had been listed in red)

in that file, we see:

Bundle version string short is ($MARKETING_VERSION)
Bundle version is $(CURRENT_PROJECT_VERSION)

that was not enough to fix the issue

I see that the Build value under Target Svija Sync, General, is 12

but it is actually under tab Build Settings, section Versioning: Current Project Version

I changed Current Project Version from 12 to 14, and it was successful

---

when I selected the build in App Store Connect, there was a "⚠️ Missing Compliance" warning.

I will assume for now that the questions I answered just afterwards about using encryption were enough to fix the issue.
