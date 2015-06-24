{CompositeDisposable} = require 'atom'
_        = require 'underscore-plus'
path     = require 'path'
fs       = require 'fs-plus'
settings = require './settings'

scope2extname = require './scope2extname'

module.exports =
  disposables: null
  config: settings.config
  grammarOverriddenPaths: {}

  activate: (state) ->
    @disposables = new CompositeDisposable
    @disposables.add atom.commands.add 'atom-workspace',
      'phrase:save': => @save()

  deactivate: ->
    @disposables.dispose()

  getSupportedScopeNames: ->
    atom.grammars.getGrammars().map (grammar) ->
      grammar.scopeName

  detectCursorScope: ->
    supportedScopeNames = @getSupportedScopeNames()

    cursor = @getEditor().getLastCursor()
    scopesArray = cursor.getScopeDescriptor().getScopesArray()
    scope = _.detect scopesArray.reverse(), (scope) ->
      scope in supportedScopeNames
    scope

  getCursorScope: ->
    editor = @getEditor()
    cursor = @getEditor().getLastCursor()
    cursor.getScopeDescriptor()

  overrideGrammarForPath: (filePath, scopeName) ->
    return if @grammarOverriddenPaths[filePath] is scopeName
    atom.grammars.clearGrammarOverrideForPath filePath
    atom.grammars.setGrammarOverrideForPath filePath, scopeName
    @grammarOverriddenPaths[filePath] = scopeName

  getEditor: ->
    atom.workspace.getActiveTextEditor()

  determineFilePath: (scopeName, URI) ->
    rootDir  = fs.normalize settings.get('root')
    basename = settings.get 'basename'

    # Strategy
    # Determine appropriate filename extension in following order.
    #  1. From scope2extname table
    #  2. Original filename's extension
    #  3. ScopeName itself.
    ext  = scope2extname[scopeName]
    ext ?= (path.extname URI).substr(0)
    ext ?= scopeName
    path.join rootDir, "#{basename}.#{ext}"

  save: ->
    editor    = @getEditor()
    URI       = editor.getURI()
    selection = editor.getLastSelection()
    scopeName = @detectCursorScope()
    languageMode = editor.languageMode
    scope = @getCursorScope()

    # {commentStartString, commentEndString}
    commentString = languageMode.commentStartAndEndStringsForScope(scope)

    filePath  = @determineFilePath scopeName, URI
    @overrideGrammarForPath filePath, scopeName

    options = searchAllPanes: settings.get('searchAllPanes')
    if settings.get('split') isnt 'none'
      options.split = settings.get 'split'

    phrase = null
    unless selection.isEmpty()
      cs = commentString.commentStartString
      phrase = """
      #{cs}Phrase:
      #{cs}---------------------------------
      #{selection.getText()}\n
      """
      selection.clear() if settings.get('clearSelection')

    atom.workspace.open(filePath, options).done (editor) =>
      switch settings.get 'pasteTo'
        when 'top'    then editor.moveToTop()
        when 'bottom' then editor.moveToBottom()

      if phrase
        editor.insertText phrase,
          select: settings.get 'select'
