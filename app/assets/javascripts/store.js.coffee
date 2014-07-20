# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

HeisenBugDev.ApplicationStore = DS.Store.extend()


# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
HeisenBugDev.ApplicationAdapter = DS.ActiveModelAdapter.extend()
HeisenBugDev.ApplicationSerializer = DS.ActiveModelSerializer.extend({});

DS.RESTAdapter.reopen
  namespace: 'api'