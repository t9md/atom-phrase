# Development phase
Alpha

# Phrase

Frequently used phrase registry.

![gif](https://raw.githubusercontent.com/t9md/t9md/12fba4ff60861ae1acd973407c93a62edf61c956/img/atom-try.gif)

# Why?
Phrase is workable code fragments or example code which you want to refer later.
While you are try&error some code and reach some conclusion.
You want to save that useful phrase to central place.
This package helps you to save and refer those phrases quickly within Atom editor.

# Features

- Paste selected text to bottom of `phrase` buffer.
- Refer phrases you collected quickly.
- Scope aware: when saved to phrase file, scope at cursor position is respected.

# How to use

## Save phrase

1. Select buffer
2. Invoke `phrase:save` command.
3. Your selected code is pasted at top of phrase file(nomral TextEditor).
4. You collect bunch of phrases this way.

## Refer phrase

1. Invoke `phrase:find` command.
2. Type phrase subject in select buffer and `confirm`.
3. Phrase file open with the cursor positioned to phrase you chose.

## Share phrase

[TODO] This feature is currently **NOT** Implemented yet. But concepts is like bellow.
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

* Normal user

```coffeescript
'atom-text-editor:not([mini])':
  'ctrl-alt-p': 'phrase:save-or-find'
```

# TODO
- [ ] ...
