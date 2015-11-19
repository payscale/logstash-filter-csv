# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require "csv"

# This filter requires a set of intput fields that will
# be joined in csv format and saved into the specified
# csv output field
#
class LogStash::Filters::Csv < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   fieldmap {
  #     src_fields => ['call', 'response']
  #     dst_field => 'csv_output'
  #   }
  # }
  #
  config_name "csv"
  
  # Field to use as source for map values
  config :src_fields, :validate => :array

  # Field to store processed values into.
  # this filter will overwrite any data already in dst_field
  config :dst_field, :validate => :string, :default => "csv_output"

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)
    @logger.debug? and @logger.debug("Running csv filter", :event => event)
    src_data = []
    @src_fields.each do |field| src_data << event[field] end
    event[@dst_field] = src_data.to_csv.strip
    filter_matched(event)

    @logger.debug? and @logger.debug("Event now: ", :event => event)

  end # def filter
end # class LogStash::Filters::Example
