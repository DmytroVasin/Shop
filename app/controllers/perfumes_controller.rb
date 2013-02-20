class PerfumesController < ApplicationController

  def index
    @perfumes = Perfume.all
  end
end
