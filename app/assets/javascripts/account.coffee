$(document).on "turbolinks:load", ->
  $("#playlists").dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#playlists").data("source")
    aoColumns: [
      {
        sTitle: "Name"
        data: "name"
        bSortable: false
      }
      {
        sTitle: "Action"
        data: "action"
        bSortable: false
        width: "150px"
      }
    ]
