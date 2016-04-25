$ ->
  $(".guess").on("ajax:before", (event) ->
    $(event.target).addClass("highlighted")
  )

  $(".guess").on("ajax:success", (event, data) ->
    if data.wrong
      switch parseInt(data.num_tries_left, 10)
        when 4
          $('.man__head').addClass 'visible'
        when 3
          $('.man__body').addClass 'visible'
        when 2
          $('.man__leg--left').addClass 'visible'
        when 1
          $('.man__leg--right').addClass 'visible'
        when 0
          $('.man__arm--left').addClass 'visible'
        when -1
          $('.man__arm--right').addClass 'visible'
        else
          return

    if data.state == 'lost'
      $('.man > *').addClass 'visible'
      $('.hangman').addClass 'game-over'
      $('.hangman__new-game').slideDown(200)

    if data.state == 'won'
      $(".guess").addClass("highlighted")
      $('.hangman__new-game').slideDown(200)

    $("#phrase").text(data.phrase)
  )
