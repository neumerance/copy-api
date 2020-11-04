namespace :airtable do
  desc "Fetch airtable columns and write to a json file"
  task fetch: :environment do
    AirtableToJsonFile.write
  end
end
