class PaymentsController < ApplicationController
  def new
    @job_listing = JobListing.find(params[:job_listing_id])
    @applied_job = @job_listing.applied_jobs.find_by(talent_id: params[:applicant_id])
    @talent = @applied_job.talent if @applied_job
    @amount = @job_listing.salary.to_i / 2
    @amount_in_dollars_in_cents = (@amount / 50 * 100)
  end

  def create
    begin
      @job_listing = JobListing.find(params[:job_listing_id])
      @applied_job = @job_listing.applied_jobs.find(params[:applied_job_id])
      @talent_id = @applied_job.talent_id
      # @job_listing = current_user.job_listings.find(params[:job_listing_id])
      # @applicants = @job_listing.applied_jobs.includes(:talent)
      # @amount = @job_listing.salary.to_i / 2

      result = Transaction.send_payment(current_user, params[:job_listing_id], params[:applied_job_id])

      if result[:success]
        redirect_to new_payment_path(job_listing_id: @job_listing.id, applicant_id: @talent_id), notice: result[:message]
      else
        redirect_to new_payment_path(job_listing_id: @job_listing.id, applicant_id: @talent_id), alert: result[:message]
      end

      # ------ NOTES NI IAN

      # 4. Update yung wallet -> wallet + amount
      # 5. Add transaction -> description: Downpayment, amount: amount (description: Downpayment, Completed)

      # final: redirect sa review (optional yung review)

      # if current_user.role_id == 3
      #   customer = Stripe::Customer.create({
      #     email: params[:stripeEmail],
      #     source: params[:stripeToken],
      #   })

      #   charge = Stripe::Charge.create({
      #     customer: customer.id,
      #     amount: @amount.to_i,
      #     description: 'Rails Stripe customer',
      #     currency: 'usd',
      #   })

      #   flash[:notice] = 'Payment was successful'
      #   @talent.update(wallet: @talent.wallet.to_i + @amount.to_i)
      #   redirect_to job_listings_path, notice: 'Payment completed successfully.'
      # else
      #   flash[:error] = 'You are not authorized to make this payment.'
      #   redirect_to root_path
      # end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path(job_listing_id: @job_listing.id)
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'Record not found.'
      redirect_to new_payment_path(job_listing_id: @job_listing.id)
    end
  end

  # The current client will send money to the talent through Stripe.
        # The client doesn't need to manually input half of the salary; it will be calculated automatically.
        # We could add another table for transactions

    # def create
    #     @applied_job = JobListing.find(2)
    #     @amount = @applied_job.salary.to_i / 2

    #     customer = Stripe::Customer.create({
    #       email: params[:stripeEmail],
    #       source: params[:stripeToken],
    #     })

    #     charge = Stripe::Charge.create({
    #       customer: customer.id,
    #       amount: @amount,
    #       description: 'Rails Stripe customer',
    #       currency: 'usd',
    #     })

    #     flash[:notice] = 'Payment was successful'
    #     redirect_to new_payment_path

    #   rescue Stripe::CardError => e
    #   flash[:error] = e.message
    #   redirect_to new_payment_path
    # end
end
