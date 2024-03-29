class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!

  def show
  end

  def edit
    @customer = current_customer

  end

  def update

    @customer = current_customer

    @customer.update(customer_params)
    redirect_to customers_my_page_path

  end

  def confirm

  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    sign_out
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path

  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email ,:is_deleted)
  end

end
