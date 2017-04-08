{WorkspaceView} = require 'atom'
LanguageEloquence = require '../lib/language-eloquence'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "LanguageEloquence", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('language-eloquence')

  describe "when the language-eloquence:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.language-eloquence')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'language-eloquence:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.language-eloquence')).toExist()
        atom.workspaceView.trigger 'language-eloquence:toggle'
        expect(atom.workspaceView.find('.language-eloquence')).not.toExist()
