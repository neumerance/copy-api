module CopyConcern
  extend ActiveSupport::Concern

  included do
    before_action :fetch_copy, only: [:show, :index]
    before_action :filter_by_since, only: :index
    before_action :print_copy, only: :show
  end

  def fetch_copy
    @copies = JSON.parse(
      File.read(::AirtableToJsonFile::FIXTURE),
      symbolize_names: true
    ).dig(:records)
  end

  def filter_by_since
    return unless params[:since].present?
    @copies = @copies.select do |record|
      created_at = Time.parse(record.dig(:createdTime))
      since = Time.at(params[:since].to_i)
      created_at.utc >= since.utc
    end
  end

  def print_copy
    if params[:id].present?
      value = @copies.detect do |record|
                record.dig(:fields, :Key) == params[:id]
              end

      @copy = {
        value: value.dig(:fields, :Copy).gsub('{', '%{') % replacements
      } if value.present?
    end
  end

  def parse_datetime
    timestamp = params[:created_at] ||
                params[:updated_at] ||
                params[:time]
    timestamp.present? ?
    Time.at(timestamp.to_i).strftime('%a %b %d %I:%M:%S%p') : ''
  end

  def replacements
    {
      name: params[:name],
      app: params[:app],
      'created_at, datetime': parse_datetime,
      'updated_at, datetime': parse_datetime,
      'time, datetime': parse_datetime
    }
  end
end
