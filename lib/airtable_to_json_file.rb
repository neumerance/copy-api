class AirtableToJsonFile
  FIXTURE = Rails.root.join('app', 'fixtures', 'copy.json')

  def self.write
    File.write(
      FIXTURE, JSON.dump(::AirtableService.new.fetch)
    )
  end
end
