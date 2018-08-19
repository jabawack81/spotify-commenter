$(document).on "turbolinks:load", ->
  $("#index-playlists").dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#index-playlists").data("source")
    aoColumns: [
      {
        sTitle: "Name"
        data: "name"
        bSortable: true
      }
      {
        sTitle: "Owner"
        data: "owner"
        bSortable: false
      }
      {
        sTitle: "Action"
        data: "action"
        bSortable: false
        width: "150px"
      }
    ]
