	class AttendancesController < ApplicationController

		def new
			@event = Event.find(params[:format])
			
		end

		def create

			event = Event.find(params[:id])

			 # Amount in cents
			@amount = 500

			customer = Stripe::Customer.create({
				email: params[:stripeEmail],
				source: params[:stripeToken],
			})


			  charge = Stripe::Charge.create({
			      customer: customer.id,
			      amount: @amount,
			      description: 'Rails Stripe customer',
			      currency: 'eur',
					})

 			@attendance = Attendance.create(stripe_customer_id: customer.id, event_id: event.id, user_id: current_user.id)

 			redirect_to event_path(event.id)

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to new_charge_path




	end

	end
