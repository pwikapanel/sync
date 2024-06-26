https://scriptingosx.com/2019/12/build-a-macos-application-to-run-a-shell-command-with-xcode-and-swiftui/

menu File › New Project
- macOS
- App
- click Next

choose options:
- Product Name: SayThis
- Interface: SwiftUI
- click Next

save in a good location using cmd-down-arrow

4 panes:
- left
- main
- right · inspector
- bottom

NEW: each pane has a little icon to show/hide

---

Click it the “Play” button in the top left to build and run the template code, a window should open which show the place holder text “Hello World!”

Select the ContentView.swift in left column.

In `struct ContentView: View`, change the text to say "Hello Armin!".

NEW: you can command click on the text to change it in the inspector

- changed Font to Body

---

adding interaction

click + to add text field

NEW: can have insertion point in code, or use preview pane to drag to correct spot












https://scriptingosx.com/2023/08/build-a-macos-application-to-run-a-shell-command-with-xcode-and-swiftui-part-2/

got error:
```
/Users/Main/Library/Mobile Documents/com~apple~CloudDocs/Projects/SwiftUI Tutorial II/MyPlayground.playground

error: execution stopped with unexpected state.

error: Execution was interrupted, reason: signal SIGCHLD.

The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
```
