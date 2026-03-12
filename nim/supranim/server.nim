import std/[httpcore, macros, macrocache, options]
import pkg/kapsis/[cli, runtime]
import pkg/supranim
import pkg/supranim/controller
import pkg/supranim/core/[request, router, response]


include ./routes
import ./controller/[pages, errors]

initApplication()
initHttpRouter()

proc startupCallback() {.gcsafe.} =
  {.gcsafe.}:
    initRouter()
    Router.errorHandler(Http404, get4xx)

App.configs = newOrderedTable[string, Document]()
App.configs["server"] = yaml("port: 3000").toJson

App.run