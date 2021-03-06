# coding: utf-8
class ReviewsController < ApplicationController
	layout 'optional_pages'

	def index
    @reviews = Review.all
    @review = Review.new
	end

	def create
    @review = Review.new(params[:review])

    if @review.save
      redirect_to reviews_path, notice: 'Ваш отзыв принят!'
    else
      @reviews = Review.all
      render 'index', notice: 'Ваш !!!'
    end
	end
end
