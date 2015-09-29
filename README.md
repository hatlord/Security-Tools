Stonegator is a Stonesoft Firewall XML configuration parsing tool. It takes the raw XML from the device configuration backup, and converts
it into an Excel compatible CSV file so that you can do rule reviews easily, or transfer the rules to another device.

Usage is simple, just ./stonrgator.rb rules.xml. It will dump the rules.csv file to the directory you run the script from.

Requirements:
csv (ships with Ruby_
nokogiri - gem install nokogiri
