#from https://github.com/braver/typewriter/blob/master/lib/run.coffee
module.exports =

  start: () ->
    requestAnimationFrame -> # wait for other dom changes
      scopes = atom.config.get('language-argdown.scopes').split(',')
      editor = atom.workspace.getActiveTextEditor()

      if editor isnt undefined # e.g. settings-view
        currentScope = editor.getRootScopeDescriptor().scopes[0]
        console.log(currentScope)
        if currentScope in scopes

          characterWidth = editor.getDefaultCharWidth()
          charactersPerLine = atom.config.get('editor.preferredLineLength', scope: [currentScope])

          atom.config.set('editor.softWrap', true, scopeSelector: currentScope)
          atom.views.getView(editor).style.maxWidth = characterWidth * (charactersPerLine + 4) + 'px'
          atom.views.getView(editor).style.paddingLeft = characterWidth * 2 + 'px'
          atom.views.getView(editor).style.paddingRight = characterWidth * 2 + 'px'
          atom.views.getView(editor).setAttribute('data-argdown', true)


  stop: () ->
    $ = require 'jquery'
    $('[data-argdown]').attr('data-argdown', false)
    $('atom-text-editor:not(.mini)').css 'max-width', ''
