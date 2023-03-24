# frozen_string_literal: true

class CreateSleepRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :sleep_records do |t|
      t.references :user
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
