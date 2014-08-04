HeisenBugDev.InlineTextArea = Ember.View.extend(
  layoutName: "inline/text_area"
  doubleClick: ->
    unless @get("isEditing")
      @set "isEditing", true
      Ember.run.scheduleOnce "afterRender", this, @focusTextField

  focusTextField: ->
    val = @$("textarea").val()
    @$("textarea").focus()
    @$("textarea").val ""
    @$("textarea").val val

  textArea: Ember.TextArea.extend(
    didInsertElement: ->
      $('#'+this.get('elementId')).autosize();

    focusOut: ->
      @save()

    keyDown: (e) ->
      @save() if e.keyCode == 13 && (e.metaKey || e.ctrlKey)

    save: ->
      parentView = @get("parentView")
      controller = parentView.get("controller")
      controller.send('save')
      parentView.set "isEditing", false
  )
)