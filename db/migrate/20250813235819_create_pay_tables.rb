class CreatePayTables < ActiveRecord::Migration[8.0]
  def change
    create_table :pay_customers, id: :primary_key do |t|
      t.string :processor, null: false
      t.string :processor_id
      t.boolean :default
      t.references :owner, polymorphic: true, index: false
      t.public_send Pay::Adapter.json_column_type, :data
      t.datetime :deleted_at
      t.timestamps

      t.index [:processor, :processor_id], unique: true
      t.index [:owner_type, :owner_id, :deleted_at], name: :customer_owner_processor_index
    end

    create_table :pay_charges, id: :primary_key do |t|
      t.references :customer, null: false, foreign_key: {to_table: :pay_customers}
      t.references :subscription, null: true
      t.string :processor_id, null: false
      t.integer :amount, null: false
      t.string :currency
      t.integer :application_fee_amount
      t.integer :amount_refunded
      t.public_send Pay::Adapter.json_column_type, :metadata
      t.public_send Pay::Adapter.json_column_type, :data
      t.timestamps

      t.index [:processor_id], unique: true
    end

    create_table :pay_subscriptions, id: :primary_key do |t|
      t.references :customer, null: false, foreign_key: {to_table: :pay_customers}
      t.string :name, null: false
      t.string :processor_id, null: false
      t.string :processor_plan, null: false
      t.integer :quantity, default: 1, null: false
      t.string :status, null: false
      t.datetime :current_period_start
      t.datetime :current_period_end
      t.datetime :trial_ends_at
      t.datetime :ends_at
      t.decimal :application_fee_percent, precision: 4, scale: 2
      t.public_send Pay::Adapter.json_column_type, :metadata
      t.public_send Pay::Adapter.json_column_type, :data
      t.timestamps

      t.index [:processor_id], unique: true
      t.index [:customer_id, :processor_id], unique: true
    end

    create_table :pay_payment_methods, id: :primary_key do |t|
      t.references :customer, null: false, foreign_key: {to_table: :pay_customers}
      t.string :processor_id, null: false
      t.boolean :default
      t.string :type
      t.public_send Pay::Adapter.json_column_type, :data
      t.timestamps

      t.index [:processor_id], unique: true
    end

    create_table :pay_webhooks, id: :primary_key do |t|
      t.string :processor
      t.string :event_type
      t.public_send Pay::Adapter.json_column_type, :event
      t.datetime :processed_at
      t.timestamps

      t.index [:processor, :event_type]
    end

    # Add foreign key constraints after all tables are created
    add_foreign_key :pay_charges, :pay_subscriptions, column: :subscription_id
  end
end
