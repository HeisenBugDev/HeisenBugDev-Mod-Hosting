HeisenBugDev.ProjectsIndexView = Ember.View.extend HeisenBugDev.PaginatedView

textareapp = Ember.TextArea.extend
  didInsertElement: ->
    $('#' + @get('elementId')).autosize();

  focusOut: ->
    @save() if (@get('parentView').get('valid') == true || @get('parentView').get('valid') == undefined)

  keyDown: (e) ->
    this.showValidationError()
    @save() if e.keyCode == 13 && (e.metaKey || e.ctrlKey) && (@get('parentView').get('valid') == true)

  showValidationError: ->
    if (Ember.isEmpty(this.get('formForModel.errors.' + this.property)))
      this.set('canShowValidationError', false)
      this.set('valid', true)
    else
      this.set('valid', false)
      this.set('canShowValidationError', true)

  save: ->
    parentView = @get("parentView").get('parentView').get('parentView')
    parentView.set "isEditing", false
    controller = parentView.get("controller")
    controller.send('save')

# Text area++
Ember.EasyForm.Config.registerInputType 'textareapp', textareapp
