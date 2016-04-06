# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  # Category
  $('#entry_medium_id').parent().hide()

  # Medium form
  $('.form-medium').hide()

  # Create entry button
  $('#button-entry-create').parent().hide()

  media = $('#entry_medium_id').html()
  $('#entry_category_id').change ->
    $('.form-medium').hide()
    $('#button-entry-create').parent().hide()
    category = $('#entry_category_id :selected').text()
    options = $(media).filter("optgroup[label='#{category}']").html()
    if options
      $('#entry_medium_id').html(options)
      $('#entry_medium_id').prepend("<option value>Select medium...</option>");
      $('#entry_medium_id').parent().show()

      $('#entry_medium_id').change ->
        medium = $('#entry_medium_id :selected').text()
        $('.form-medium').hide()
        if medium == "Quote"    
          $('#form-quote').show()
          $('#button-entry-create').show()
          $('#button-entry-create').parent().show()
        else if medium == "Picture"
          $('#form-picture').show()
          $('#button-entry-create').show()
          $('#button-entry-create').parent().show()
        else
          $('.form-medium').hide()
          $('#button-entry-create').parent().hide()

    else
      $('#entry_medium_id').empty()
      $('#entry_medium_id').parent().hide()
      $('.form-medium').hide()
      $('#button-entry-create').parent().hide()
