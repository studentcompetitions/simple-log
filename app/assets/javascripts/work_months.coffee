# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".panel.work-month .panel-heading").click ->
    $(this).next(".panel-body").slideToggle("fast")
    $(this).find(".arrow").toggleClass("collapse")
