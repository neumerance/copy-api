class AirtableService
  include HTTParty
  base_uri ENV['AIRTABLE_BASE_URL']

  def fetch
    response = self.class.get(
      "/#{ENV['AIRTABLE_TABLE']}/Table%201?"\
      "api_key=#{ENV['AIRTABLE_KEY']}"
    )

    JSON.parse(response.body)
  end
end
