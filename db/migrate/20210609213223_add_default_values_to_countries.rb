class AddDefaultValuesToCountries < ActiveRecord::Migration[6.0]
  def change
    change_column_default :countries, :status, 'N/A'
    change_column_default :countries, :quarantine, 'N/A'
    change_column_default :countries, :test, 'N/A'
    change_column_default :countries, :content, 'N/A'
    change_column_default :countries, :government_url, 'https://www.gov.uk/guidance/travel-advice-novel-coronavirus'
    change_column_default :countries, :upcoming_changes, 'N/A'
  end
end
