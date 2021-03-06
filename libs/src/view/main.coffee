APPLICATION = undefined
window.onload = ->
  # create application main
  APPLICATION = new appsmain()

  # get browser size
  bounds = plustick.getBounds()
  browser_width = bounds.size.width
  browser_height = bounds.size.height

  # get user setting
  backgroundColor = APPLICATION.backgroundColor || "rgba(0, 0, 0, 1.0)"

  # create root view
  rootview = document.createElement("div")
  rootview.setAttribute("id", "__rootview__")
  document.body.append(rootview)

  # fit contents size to browser
  if (APPLICATION.width? || APPLICATION.height?)
    contents_width = APPLICATION.width || parseInt(Math.floor(browser_width / (browser_height / APPLICATION.height)))
    contents_height = APPLICATION.height || parseInt(Math.floor(browser_height / (browser_width / APPLICATION.width)))
    APPLICATION.width = contents_width
    APPLICATION.height = contents_height

    # browser resolution
    bounds = plustick.getBounds()
    browser_width = bounds.size.width
    browser_height = bounds.size.height

    # calc scale
    scale_x = browser_width / contents_width
    scale_y = browser_height / contents_height

    scale_mode = 1
    height_tmp = contents_height * scale_x

    if (height_tmp > browser_height)
      scale_mode = 2

    # calc width/height
    if (scale_mode == 1)
      real_height = contents_height * scale_x
      left = 0
      top = parseInt(Math.floor((browser_height - real_height) / 2))
      scale = scale_x
    else
      real_width = contents_width * scale_y
      left = parseInt(Math.floor((browser_width - real_width) / 2))
      top = 0
      scale = scale_y

    rootview.style.transformOrigin = "0px 0px 0px"
    rootview.style.transform = "scale(#{scale}, #{scale})"

  # does not fit contents size to browser
  else
    contents_width = browser_width
    contents_height = browser_height
    APPLICATION.width = browser_width
    APPLICATION.height = browser_height
    left = 0
    top = 0

  rootview.style.position = "absolute"
  rootview.style.width = "#{contents_width}px"
  rootview.style.height = "#{contents_height}px"
  rootview.style.left = "#{left}px"
  rootview.style.top = "#{top}px"

  rootview.style.margin = "0px 0px 0px 0px"
  rootview.style.backgroundColor = backgroundColor
  rootview.style.overflow = "hidden"

  if (typeof APPLICATION.createHtml == 'function')
    APPLICATION.createHtml().then (html)=>
      if (html?)
        document.querySelector('#__rootview__').innerHTML = html
      if (typeof APPLICATION.viewDidAppear == 'function')
        APPLICATION.viewDidAppear()

