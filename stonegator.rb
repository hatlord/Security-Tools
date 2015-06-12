#!/usr/bin/env ruby
#Stonegator is a Stonegate Firewall XML to CSV/Excel convertor.
require 'nokogiri'
require 'csv'

fwpol = File.open(ARGV[0]).read

CSV.open('rules.csv', "wb") do |csv|
  csv << %w(policyref templateref name disabled? parentref rank rulenumber action source destination service)
  
rule_info = {}
  Nokogiri::XML(fwpol).xpath('./generic_import_export/fw_policy').each do |polinfo|
    rule_info[:policyref]     = polinfo.xpath("@inspection_policy_ref").text
    rule_info[:templateref]   = polinfo.xpath("@template_policy_ref").text
    rule_info[:name]          = polinfo.xpath("@name").text
  polinfo.xpath('./access_entry/rule_entry').each do |ruleinfo|
    rule_info[:enabled]       = ruleinfo.xpath("@is_disabled").text
    rule_info[:parentref]     = ruleinfo.xpath("@parent_rule_ref").text
    rule_info[:rank]          = ruleinfo.xpath("@rank").text
    rule_info[:rulenumber]    = ruleinfo.xpath("@tag").text
    rule_info[:action]        = ruleinfo.xpath("./access_rule/action/@type").text
  ruleinfo.xpath('./access_rule/match_part').each do |rules|
    rule_info[:source]        = rules.xpath("./match_sources/match_source_ref/@value").map(&:text).join("\r")
    rule_info[:destination]   = rules.xpath("./match_destinations/match_destination_ref/@value").map(&:text).join("\r")
    rule_info[:service]       = rules.xpath("./match_services/match_service_ref/@value").map(&:text).join("\r")

    
    csv << rule_info.values
      end
    end
  end
end	