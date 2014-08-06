$ ->
  if namespace.controller is "visualizations" and namespace.action in ["displayVis","show"]
    ###
    Fullscreen Visualizations
    ###
    hidden = false
    originalWidth = 210
    ($ '#fullscreen-viz').click (e) ->
      fullscreenEnabled = document.fullscreenEnabled || document.mozFullScreenEnabled ||
      document.webkitFullscreenEnabled
      fullscreenElement = document.fullscreenElement || document.mozFullScreenElement ||
      document.webkitFullscreenElement
      icon = ($ '#fullscreen-viz').find('i')
      if !fullscreenElement
        window.globals.fullscreen = true
        icon.removeClass('icon-resize-full')
        icon.addClass('icon-resize-small')
        fullscreenVis = ($ '#viscontainer')[0]
        browserFullscreenMethod = fullscreenVis.webkitRequestFullScreen || fullscreenVis.mozRequestFullScreen ||
        fullscreenVis.requestFullScreen || fullscreenVis.msRequestFullscreen
        browserFullscreenMethod.call(fullscreenVis)
      else
        window.globals.fullscreen = false
        icon.removeClass('icon-resize-small')
        icon.addClass('icon-resize-full')
        if document.webkitExitFullscreen
          document.webkitExitFullscreen()
        else if document.mozCancelFullScreen
          document.mozCancelFullScreen()
        else if (document.cancelFullScreen)
          document.cancelFullScreen()
        else if (document.msExitFullscreen)
          document.msExitFullscreen()
          
    ($ document).on('webkitfullscreenchange mozfullscreenchange fullscreenchange', ->
      if !hidden
        ($ '#controldiv').width(originalWidth)
      #Deal with Safari and Firefox resizing peculiarities
      if ((navigator.userAgent.search("Safari") >= 0 && navigator.userAgent.search("Chrome") < 0) or
         navigator.userAgent.indexOf('Firefox') > -1)
        ($ window).trigger('resize')
      if ($ '#fullscreen-viz').attr('title') == 'Maximize'
        ($ '#fullscreen-viz').attr('title', 'Minimize')
      else if ($ '#fullscreen-viz').attr('title') == 'Minimize'
        ($ '#fullscreen-viz').attr('title', 'Maximize')
    )

    ($ '#control_hide_button').on('click', () ->
      hidden = !hidden
    )

    ###
    Add Select All Options for Y Axis to Timeline, Bar Chart, and Scatter Plot
    ###
    window.addSelectAllY = (id) ->
      console.log("#{id}")
      console.log('window.addSelectAllY')
      ($ "##{id}").prepend(
        "<div class='inner_control_div'>
          <div class='checkbox'>
            <label class='all-y'>
              <input id='select-all-y' type='checkbox'> #Select All </input>
            </label>  
          </div>
        </div>"
      )
      
      ($ "##{id}").height(($ "##{id}").height() + ($ '.checkbox:first').height() / 2)
    window.areAllFieldsSelected = () ->
      if data.normalFields.length == globals.fieldSelection.length
        return true
      else
        return false
      
    ($ document).ready () ->
      window.tempFields = data.normalFields
      console.log 'window.tempFields = ' + window.tempFields
      #originalWidth = 210
      #($ '#controldiv').width(210)
      console.log window.globals.curVis.canvas
      if globals.curVis.canvas == 'timeline_canvas'
        console.log 'timeline_canvas'
        id = ($ '#controldiv').find('.outer_control_div:eq(1)').attr('id')
        window.allYAxes = areAllFieldsSelected()
        window.addSelectAllY(id)
      else if globals.curVis.canvas == 'scatter_canvas'
        console.log 'scatter_canvas'
        id = ($ '#controldiv').find('.outer_control_div:eq(2)').attr('id')
        window.addSelectAllY(id)
      else if globals.curVis.canvas == 'bar_canvas'
        console.log('hello')
        id = ($ '#controldiv').find('.outer_control_div:eq(1)').attr('id')
        window.addSelectAllY(id)
      if window.allYAxes
        ($ '#select-all-y').prop('checked', true)
      window.globals.curVis.update()
      
      ($ '.all-y').on('click', () ->
        console.log('hello')
        window.allYAxes = !window.allYAxes
        if window.allYAxes == true
          console.log globals.fieldSelection
          console.log data.normalFields
          globals.fieldSelection = data.normalFields
          ($ "#yAxisControl").find('.y_axis_input').each (i,j) ->
            ($ j).prop('checked', true)
        else
          globals.fieldSelection = []
          ($ "#yAxisControl").find('.y_axis_input').each (i,j) ->
            ($ j).prop('checked', false)
        window.globals.curVis.update()
      )
      ($ '.y_axis_input').on('click', () ->
        console.log("yAxisControl.length = #{($ '#yAxisControl').find('.y_axis_input').length}")
        if ($ '#yAxisControl').find('.y_axis_input').length == globals.fieldSelection.length
          window.allYAxes = true
          ($ '#select-all-y').prop('checked', true)
        else
          window.allYAxes = false
          ($ '#select-all-y').prop('checked', false)
        #data.normalFields = window.tempFields
        #data.normalFields = data.normalFields
    )
  
   
      
    ($ '#ui-id-2').on('click', () ->
        #window.globals.curVis.start()
        window.allYAxes = window.areAllFieldsSelected()
        addSelectAllY(($ '#controldiv').find('.outer_control_div:eq(1)').attr('id'))
        if window.allYAxes
          ($ '#select-all-y').prop('checked', true)
      )
      
    ($ '#ui-id-3').on('click', () -> 
      #window.globals.curVis.start()
      addSelectAllY(($ '#yAxisControl').find('.outer_control_div:first').attr('id'))
      window.allYAxes = window.areAllFieldsSelected()
      if window.allYAxes
        ($ '#select-all-y').prop('checked', true)
    )
       
    ($ '#ui-id-4').on('click', () ->
      #window.globals.curVis.start()
      addSelectAllY(($ '#controldiv').find('.outer_control_div:eq(1)').attr('id'))
      window.allYAxes = window.areAllFieldsSelected()
      if window.allYAxes
        ($ '#select-all-y').prop('checked', true)
    )  
    
    ($ window).resize () -> 
      ($ '#controldiv').innerWidth(210)
      
      