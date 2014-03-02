updateCountdown = ->
    # 140 is the max message length
  remaining = 140 - jQuery('#micropost_content').val().length
  jQuery('.counter').text(remaining + ' characters remaining')

jQuery -> 
  updateCountdown()
  $('#micropost_content').change(updateCountdown)
  $('#micropost_content').keyup(updateCountdown)
