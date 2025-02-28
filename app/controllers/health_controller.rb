class HealthController < ApplicationController
  # This is a simple health check endpoint that returns a 200 status code
  # used by Kamal to determine if the application is running.
  def up
    head :ok
  end
end
