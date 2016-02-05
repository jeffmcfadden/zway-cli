require "zway/cli/version"
require 'net/http'
require 'json'
require 'yaml'

module ZWay
  module Cli
    class Client

      attr_accessor :host
      attr_accessor :username
      attr_accessor :password
      attr_accessor :session_id
      attr_accessor :aliases

      def initialize( host = "", username = "", password = "" )
        self.host     = host
        self.username = username
        self.password = password
      end

      def load_config!
        if File.exists?( File.join(Dir.home, ".zway_config") )
          config = YAML.load_file(File.join(Dir.home, ".zway_config"))

          self.host     = config["host"]     rescue ""
          self.username = config["username"] rescue ""
          self.password = config["password"] rescue ""
          self.aliases  = config["aliases"]  rescue []
        else
          File.open( File.join(Dir.home, ".zway_config"), 'w' ){ |f|
config_template = %Q(---
host:     192.168.10.25:8083
username: foobarjones
password: fizzbuzz
aliases:
    - livingroom_lights: ZWayVDev_zway_15-0-37

)


            f.write( config_template )
          }
        end

        if File.exists?( File.join(Dir.home, ".zway_session_id") )
          self.session_id = File.open( File.join(Dir.home, ".zway_session_id") ).read.strip
        else
          # Nothing right now
        end
      end

      def login!
        uri = URI( "http://#{self.host}/ZAutomation/api/v1/login")
        req = Net::HTTP::Post.new(uri)
        req.body = { form: true, default_ui: 1, keepme: true, login: "#{self.username}", password: "#{self.password}" }.to_json
        req.content_type = 'application/json'
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(req)
        end

        self.session_id = res['set-cookie'].split( ';' ).delete_if{ |i| i.split( '=' )[0] != 'ZWAYSession' }.first.split( "=" ).last rescue nil

        if self.session_id.nil?
          puts "Error logging in."
          exit 1
        else
          File.open( File.join(Dir.home, ".zway_session_id"), 'w+' ){ |f| f.write( self.session_id ) }
        end
      end

      def on( device )
        data = run_command( device, '/command/on' )
        puts data["message"]
      end

      def off( device )
        data = run_command( device, '/command/off' )
        puts data["message"]
      end

      def update( device )
        data = run_command( device, '/command/update' )
        puts data["message"]
      end

      def level( device )
        data = run_command( device, '' )
        puts data["data"]["metrics"]["level"] rescue data
      end

      def run_command( device, command )
        self.login! if self.session_id.nil?

        self.aliases.each do |a|
          if a[device]
            device = a[device]
          end
        end

        uri = URI( "http://#{self.host}/ZAutomation/api/v1/devices/#{device}#{command}")
        req = Net::HTTP::Get.new(uri)
        req['Cookie']="ZWAYSession=#{self.session_id}"
        res = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(req)
        end
        res.body

        # puts "Body: "
        # puts res.body

        if res.code == "401"
          puts "Unauthorized. Try logging in first."
          exit 1
        else
          return JSON.parse( res.body )
        end
      end

    end #Client
  end
end