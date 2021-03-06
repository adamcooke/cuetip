# frozen_string_literal: true

require 'active_support/core_ext/numeric/bytes'

class CreateCuetipQueuedJobsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :cuetip_jobs do |t|
      t.string :class_name
      t.text :params, limit: 1.megabyte
      t.datetime :run_after
      t.integer :executions, default: 0

      # Status
      t.string :status

      # Timings
      t.datetime :started_at
      t.datetime :finished_at

      # Exceptions
      t.string :exception_class
      t.string :exception_message
      t.text :exception_backtrace

      # Config options
      t.string :queue_name
      t.integer :maximum_execution_time
      t.integer :ttl
      t.integer :retry_count
      t.integer :retry_interval
      t.integer :delay_execution

      # Add a parent
      t.string :associated_object_type
      t.bigint :associated_object_id

      t.timestamps null: true

      t.index :associated_object_id
      t.index :class_name, length: 10
      t.index :status, length: 10
    end
  end
end
