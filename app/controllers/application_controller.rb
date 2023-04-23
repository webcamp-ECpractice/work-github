class ApplicationController < ActionController::Base


  def new
    @customer = Customer.new
  end 

