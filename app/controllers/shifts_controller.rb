class ShiftsController < ApplicationController
	def show
		Shift.all
	end


	def new
		@shift = Shift.new
	end

	def create
		@shift = Shift.new(shift_params)
		if @shift.save
			redirect_to shifts_path
		else
			redirect_to users_path
		end
	end

	private

	def shift_params
		params.require(:shift).permit(:user_id, :start, :finish, :break_length)
	end

end



