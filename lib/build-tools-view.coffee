{$,View} = require 'atom'
parser = require './build-parser.coffee'
ml = require './message-list.coffee'

module.exports =
class BuildToolsCommandOutput extends View
  @content: ->
    @div class: 'build-tools-cpp', outlet: 'btdiv', =>
      @div class: 'commandheader', outlet: 'cheader', =>
          @div class: 'commandname'
          @div class: 'commandsettings'
          @div class: 'commandclose'
      @div class: 'commandoutput build-tools-cpp-hidden', outlet: 'cmd_output'

  visible:
    header: false
    settings: false
    output: false
  lockoutput: false

  initialize: ->
    @on 'click','.commandclose', =>
      @hideSettings()
      @hideBox()
    @on 'click','.commandsettings', =>
      @showSettings()
    @on 'click','.commandsettingsup', =>
      @hideSettings()
    @on 'mousedown', '.commandheader', @startResize
    return

  serialize: ->

  destroy: ->
    @detach()

  attach: ->
    atom.workspace.addBottomPanel({item: this})

  toggleSettings: ->
    if @visible.settings
      @hideSettings()
    else
      @showBox()
      @showSettings()

  showSettings: ->
    if not @visible.settings
      @cheader.after(ml.settings)
      @find('.settings').addClass('settings-abs') if @visible.output
      @find('.commandsettings').removeClass('commandsettings').addClass('commandsettingsup')
      @visible.settings = true

  hideSettings: ->
    if @visible.settings
      ml.settings.detach()
      @find('.commandsettingsup').removeClass('commandsettingsup').addClass('commandsettings')
      @visible.settings = false

  toggleBox: ->
    if @visible.header
      @hideBox()
    else
      @showBox()

  hideBox: ->
    @detach() if @visible.header
    @visible.header = false

  showBox: ->
    @attach() if not @visible.header
    @visible.header = true

  cancel: ->
    if @visible.settings
      @hideSettings()
    else
      @hideBox()

  startResize: (e) => # pass in the mousedown event
    $(document).on 'mousemove', @resize
    $(document).on 'mouseup', @endResize
    @padding = $(document.body).height() - (e.clientY + @find('.commandoutput').height()) # calculate padding offset

  resize: ({pageY, which}) =>
    return @endResize() unless which is 1
    @find('.commandoutput').height($(document.body).height() - pageY - @padding) #includes padding offset

  endResize: =>
    $(document).off 'mousemove', @resize
    $(document).off 'mouseup', @endResize

  hideOutput: ->
    @find('.commandoutput').addClass('build-tools-cpp-hidden')
    @visible.output = false

  showOutput: ->
    @find('.commandoutput').removeClass('build-tools-cpp-hidden')
    @visible.output = true

  clear: ->
    @find('.commandoutput').text('')
    parser.clearVars()

  outputLineParsed: (line,script) =>
    line = line.toString()
    parser.toLine line, script, @printLine

  openFile: (element) ->
    lineno = parseInt($(this).attr('row'))
    linecol= parseInt($(this).attr('col'))
    if $(this).attr('name') isnt ''
      atom.workspace.open($(this).attr('name'),{
          initialLine: lineno-1
          initialColumn: linecol-1
        })

  finishConsole: ->
    parser.poplines(@printLine)
    @find('.filelink').on 'click', @openFile

  printLine: (message) =>
    @showOutput() if !@lockoutput
    @cmd_output.append(message)
    @cmd_output.scrollTop(@cmd_output[0].scrollHeight)

  setHeader: (name) ->
    @find('.commandname').html("<b>#{name}</b>")

  lock: ->
    @lockoutput = true

  unlock: ->
    @lockoutput = false
