class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:top,:index,:about]
end
