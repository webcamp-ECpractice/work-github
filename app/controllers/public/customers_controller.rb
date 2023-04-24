class Public::CustomersController < ApplicationController

  def show
  end

  def edit

  end

  def update

    @customer = Customer.find(current_customer.params)

    @customer.update(customer_params)
    redirect_to customers_my_page_path

  end

  def confirm

  end

  def withdrawl

  end

end
