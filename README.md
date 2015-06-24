# Development phase
Alpha

# Phrase

Frequently used phrase registry.

# Why?
Phrase is workable code fragments or example code which you want to refer later.
While you are try&error some code and reach some conclusion.
You want to save that useful phrase to central place.
This package helps you to save and refer those phrases quickly within Atom editor.

# Features

- Paste selected text to bottom of `phrase` buffer.
- Refer phrases you collected quickly.
- Scope aware: when saved to phrase file, scope at cursor position is respected.

# Command

* `phrase:open`: open or save selected text to phrase file based on cursor scope.

# How to use

## Save phrase

1. Select buffer
2. Invoke `phrase:open` command.
3. Your selected code is pasted at top of phrase file(nomral TextEditor).
4. You collect bunch of phrases this way.

## Refer phrase

1. Invoke `phrase:open` command without selection.

## Share phrase
[NOTE] Features and commands described in this `Share phrase` section is **NOT** yet implemented.
But concepts are like bellow.

This package provide, mechanism to share your phrases to others.
This need phrase registries on web.
Phrase ragistries might be
 - Dropbox folder
 - Gist
 - github repositiory

- update phrases
 - `phrase:update-all`
 - `phrase:update`: select repository
 - `phrase:publish`: publish current phrase file to repository

Configure phrase repository
 - `phrase:open-config`

# Keymap
No keymap by default.

e.g.
```coffeescript
'atom-workspace:not([mini])':
  'ctrl-alt-p': 'phrase:open'
```

# TODO
- [ ] `phrase:find` command let you select phrase title from select-list.
- [ ] Auto insert result to `Output:` placeholder.
- [ ] Select phrase and run with one commmand like `phrase:update-output`.
- [ ] Put cursor to title with `tab`?
