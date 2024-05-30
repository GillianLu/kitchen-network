class TransactionsController < ApplicationController
    def index
        if current_user.role == 3
            @transactions = current_user.transactions_as_client.includes(:talent, :job_listing)
        elsif current_user.role == 2
            @transactions = current_user.transactions_as_talent.includes(:client, :job_listing)
        else
            @transactions = Transaction.includes(:client, :talent, :job_listing).all
        end
    end
end
