class OrderMailer < ApplicationMailer
    default from: 'buithikieu16tclc3@gmail.com'
    def confirm_order(user,order)
    @user = user
    @order= order
    mail to: user.email, subject: "Confirm Order"
    end

 end
