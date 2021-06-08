class CountriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :compare]
  def index
    @countries = Country.all
  end

  def show
    @country = Country.find(params[:id])
  end

  def compare
    if params['/countries/compare']
      if params['/countries/compare'][:country_1].present?
        @country_1 = Country.find(params['/countries/compare'][:country_1].to_i)
      end
      if params['/countries/compare'][:country_2].present?
        @country_2 = Country.find(params['/countries/compare'][:country_2].to_i)
      end
      if params['/countries/compare'][:country_3].present?
        @country_3 = Country.find(params['/countries/compare'][:country_3].to_i)
      end
    end
    @countries = Country.all
  end


end
