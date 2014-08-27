HeisenBugDev.FileUploadComponent = Ember.FileField.extend
  url: ''
  filesDidChange: (->
    uploadUrl = @get('url')
    files     = @get('files')

    uploader = Ember.Uploader.create
      url: uploadUrl

    unless Ember.isEmpty(files)
      uploader.upload(files[0])
  ).observes('files')
