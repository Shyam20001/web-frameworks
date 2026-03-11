#
# This is the main file for the Supranim application.
#
# It initializes the application, loads configurations,
# and sets up the necessary services and middlewares.
#
import pkg/supranim

#
# Init core modules using `init` macro
#
App.init(skipLocalConfig = true) do:
  App.configs = newOrderedTable[string, Document]()
  App.configs["server"] = yaml("").toJson

# Define CLI commands for the application
import pkg/kapsis/[runtime, cli]
proc startCommand(v: Values) =
  ## Kapsis `init` command handler
  initStartCommand(v, createDirs = false)

  App.configs["server"].contents = %*{
    "port": int(v.get("--port").getPort)
  }

App.cli do:
  start path(directory), port(--port):
    ## Init the app with the given installation path

#
# Initialize available Service Providers.
#
# Configuration files are defined as YAML in the
# `config/` directory.
#
App.services do:
  # initialize your service providers here
  discard

#
# Starts the application. This will start the HTTP
# server and listen for incoming requests.
#
# The application will be available at the specified port.
#
App.run()