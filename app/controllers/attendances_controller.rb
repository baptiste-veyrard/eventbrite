	class AttendancesController < ApplicationController

		def new
			@event = Event.find(params[:format])
			
		end

		def create

			# Amount in cents
			@amount = 50

			customer = Stripe::Customer.create({
				email: params[:stripeEmail],
				source: params[:stripeToken],
			})

			charge = Stripe::Charge.create({
				customer: customer.id,
				amount: @amount,
				description: 'test',
				currency: 'eur',
			})

			rescue Stripe::CardError => e
				flash[:error] = e.message
				redirect_to new_charge_path


		if @event.attendances << current_user

			flash[:notice] = "your participation is validate !"
			redirect_to event_path(params[:event.id])
			return
		else
			flash[:notice] = "Error, try again !"
			render 'new'

		end


	end

	end
