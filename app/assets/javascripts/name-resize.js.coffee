# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

resize_titles = ->
    $(".bounty-square .name").each ->
        name_length = $(this).text().length
        font_size_num = 280 - (name_length * 3.5)
        font_size = "#{font_size_num}%"
        $(this).css("font-size", font_size)
        $(this).css("line-height", "95%")


$(document).ready resize_titles
$(document).on "page:load", resize_titles