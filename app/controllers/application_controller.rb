class ApplicationController < ActionController::API
  # include scout instrumentation needed for API controllers
  include ScoutApm::Instruments::ActionControllerRails3Rails4Instruments
end
