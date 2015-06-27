{CompositeDisposable} = require 'atom'
# _        = require 'underscore-plus'
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
      'phrase:open': => @open()

  deactivate: ->
    @disposables.dispose()

  getSupportedScopeNames: ->
    atom.grammars.getGrammars().map (grammar) ->
      grammar.scopeName

  getCursorScope: ->
    editor = @getEditor()
    [rowStart, rowEnd] = editor.getLastSelection().getBufferRowRange()
    editor.scopeDescriptorForBufferPosition([rowStart, 0])

  getScopeName: (scope)->
    scopeNames = scope.getScopesArray().slice().reverse()
    for scopeName in scopeNames when scopeName in @getSupportedScopeNames()
      return scopeName
    null

  getCommentString: (languageMode, scope) ->
    # returned object is {commentStartString, commentEndString}
    @getEditor().languageMode.commentStartAndEndStringsForScope(scope)

  overrideGrammarForPath: (filePath, scopeName) ->
    return if @grammarOverriddenPaths[filePath] is scopeName
    atom.grammars.clearGrammarOverrideForPath filePath
    atom.grammars.setGrammarOverrideForPath filePath, scopeName
    @grammarOverriddenPaths[filePath] = scopeName

  getEditor: ->
    atom.workspace.getActiveTextEditor()

  determineFilePath: (scopeName, URI) ->
    rootDir  = fs.normalize settings.get('root')

    # Strategy
    # Determine appropriate filename extension in following order.
    #  1. From scope2extname table
    #  2. Original filename's extension
    #  3. ScopeName itself.
    ext  = scope2extname[scopeName]
    ext ?= (path.extname URI).substr(0)
    ext ?= scopeName
    path.join rootDir, "phrase.#{ext}"

  open: ->
    editor        = @getEditor()
    URI           = editor.getURI()
    selection     = editor.getLastSelection()
    scope         = @getCursorScope()
    scopeName     = @getScopeName(scope)
    commentString = @getCommentString(editor.languageMode, scope)

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
