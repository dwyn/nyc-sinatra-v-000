class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		# binding.pry
		erb :'figures/index'
	end

	get '/figures/new' do
		erb :'/figures/new'
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		# binding.pry
		erb :'/figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find_by_id(params[:id])
		# binding.pry
		erb :'figures/edit'
	end

	post '/figures' do
		@figure = Figure.create(params["figure"])
		if !params[:landmark][:name].empty?
			@figure.landmarks << Landmark.create(params[:landmark])
		end

		if !params[:title][:name].empty?
			@figure.titles << Title.create(params[:title])
		end

		@figure.save
		redirect to "/figures/#{@figure.id}"
	end

	post '/figures/:id' do
		@figure = Figure.find_by_id(params[:id])
		@figure.update(params["figure"])
		if !params["landmark"]["name"].empty?
			@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
		end

		@figure.save

		redirect to "figures/#{@figure.id}"
	end
end
