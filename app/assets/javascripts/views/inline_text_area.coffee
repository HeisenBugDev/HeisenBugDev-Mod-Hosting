HeisenBugDev.InlineTextArea = Ember.View.extend Ember.Validations.Mixin,
  layoutName: "inline/text_area"

  actions:
    edit: ->
      unless @get("isEditing")
        @set "isEditing", true
        Ember.run.scheduleOnce "afterRender", this, @focusTextField

  doubleClick: ->
    @send('edit')

  focusTextField: ->
    val = @$("textarea").val()
    @$("textarea").focus()
    @$("textarea").val ""
    @$("textarea").val val
