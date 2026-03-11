import pkg/supranim/controller

ctrl getHomepage:
  ## renders the home page
  req.send(200)

ctrl getUserId:
  ## renders the user page with the specified id
  let id = req.params["id"]
  req.resp(Http200, id)

ctrl postUser:
  ## creates a new user with the provided data
  req.send(200)