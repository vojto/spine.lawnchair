Spine     = require('spine')
Lawnchair = require('lib/lawnchair')

Spine.Model.Lawnchair =
  extended: ->
    @change @saveLawnchair
    @fetch @loadLawnchair
  
  saveLawnchair: (record, type) ->
    @_prepareStore (store) =>
      data = JSON.parse(JSON.stringify(record))
      data.key = data.id
      delete data.id
      store.save(data)
  
  loadLawnchair: ->
    @_prepareStore (store) =>
      store.all (records) =>
        records = for record in records
          record.id = record.key
          delete record.key
          record
        @refresh records
      
  _prepareStore: (callback) ->
    return callback(@_lawnchairStore) if @_lawnchairStore?
    model = this
    new Lawnchair {name: @name}, ->
      model._lawnchairStore = this
      callback(this)