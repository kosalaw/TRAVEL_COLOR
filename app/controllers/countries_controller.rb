class CountriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :compare, :explore]
  def index
    @countries = Country.all

    countries = Country.all
    @temp_array = {}
    countries.each do |country|
      if country.status == nil || country.status == " "
          @temp_array[country.name] = {
            id: country.id,
            status: country.status,
            test: country.test,
            quarantine: country.quarantine,
            color: country.color,
            upcoming_changes: country.upcoming_changes,
            content: country.content
          }
      end
    end
    @json_array = @temp_array.to_json
  end

  def show
    @review = Review.new
    @country = Country.find(params[:id])
    @alert = Alert.where(country: @country, user: current_user).first
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
    @countries = Country.order(name: :asc)
  end

  def explore
    @country = Country.find(params[:id])
  end

  def flights
  end

end
