class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    countries = Country.all
    @temp_array = {}

    countries.each do |country|
      if country.status == nil || country.status == " "
          @temp_array[country.name] = {
            content: country.content,
            status: country.status,
            test: country.test,
            quarantine: country.quarantine,
            color: country.color,
            upcoming_changes: country.upcoming_changes
          }

      end
    end

    @json_array = @temp_array.to_json

    # hash with county's url pass to JS script - so when click on country redirect to country page.




  end
end
