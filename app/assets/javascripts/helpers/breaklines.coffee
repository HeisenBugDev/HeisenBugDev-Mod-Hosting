Ember.Handlebars.helper 'breaklines', (text) ->
    text = Handlebars.Utils.escapeExpression(text)
    text = text.replace(/(\r\n|\n|\r)/gm, '<br>')
    new Handlebars.SafeString(text);