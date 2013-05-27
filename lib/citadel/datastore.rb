module Citadel
require "sequel"

  module Datastore
    class Connection
      attr_accessor :db
      attr_accessor :inspections

      def initialize
        @db = Sequel.sqlite("#{Settings[:working_dir]}/database.sqlite")
        begin
          @db.create_table :inspections do 
            primary_key :id
            column :sha, :text, :unique=>true
            column :result, :boolean
            column :started, :datetime
            column :error_data, :text
          end
        rescue Sequel::DatabaseError => e
        end
        @inspections = @db[:inspections]
      end
    end

  end

end