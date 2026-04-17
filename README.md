# Text2Paste Plasmoid

Text2Paste is a lightweight KDE Plasma 6 widget designed for users who frequently need to copy specific strings of text—such as API tokens, frequently used snippets, or temporary passwords—into their clipboard with a single click.

Unlike a general-purpose clipboard manager, Text2Paste allows you to maintain a persistent list of important snippets that don't get buried under new clipboard history.

## Features

- **Quick Copy**: One-click button to copy any saved item to your clipboard.
- **Easy Management**: Add new snippets via a simple input field and remove them when no longer needed.
- **Plasma 6 Ready**: Built using Kirigami and Plasma 6 components for a native Look & Feel.

## Installation

### Prerequisites
- KDE Plasma 6
- `plasma-sdk` (for development/testing)

### Manual Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/gaetan1903/text2paste-plasmoid.git
   cd text2paste-plasmoid
   ```
2. Install the plasmoid:
   ```bash
   kpackagetool6 --type Plasma/Applet --install .
   ```
3. To update the plasmoid after making changes:
   ```bash
   kpackagetool6 --type Plasma/Applet --upgrade .
   ```

## Development

To preview the widget without installing it:
```bash
plasmoidviewer -a com.github.gaetan1903.text2paste
```

## Roadmap

### Phase 1: Persistence & UX Improvements (Current Focus)
- [x] **Data Persistence**: Save the list of snippets to a local configuration file so they persist after reboot/session restart.
- [x] **Visual Feedback**: Show a success icon when an item is successfully copied to the clipboard.
- [x] **Privacy Mode**: Mask sensitive snippets (passwords, tokens) with dots and provide a toggle to reveal them.
- [x] **Input Validation**: Prevent adding empty strings or duplicate entries.

### Phase 2: Feature Expansion
- [x] **Labels/Aliases**: Allow users to give a "Name" to a snippet (e.g., "Prod Token") instead of showing the full raw text.
- [ ] **Reordering**: Drag-and-drop support to reorder the list of snippets.
- [ ] **Search/Filter**: Add a search bar for users with many saved snippets.

### Phase 3: Integration & Advanced Options
- [ ] **Categorization**: Group snippets into categories or tabs.
- [ ] **Import/Export**: Allow backup and restoration of the snippet list.
- [ ] **Global Shortcuts**: Assign specific shortcuts to copy specific items from the list.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

- **Gaetan Jonathan** - [gaetan1903](https://github.com/gaetan1903)
