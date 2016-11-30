class ImportLegacySchema < ActiveRecord::Migration[5.0]
  def change
    create_table "authem_sessions", force: :cascade do |t|
      t.string :role, null: false
      t.string :subject_type, null: false
      t.integer :subject_id, null: false
      t.string :token, limit: 60, null: false
      t.datetime :expires_at, null: false
      t.integer :ttl, null: false
      t.timestamps
      t.index ["expires_at", "subject_type", "subject_id"], name: "index_authem_sessions_subject", using: :btree
      t.index ["expires_at", "token"], name: "index_authem_sessions_on_expires_at_and_token", unique: true, using: :btree
    end

    create_table :avatars do |t|
      t.belongs_to :user
      t.string :url
      t.timestamps
    end

    create_table :billable_weeks do |t|
      t.belongs_to :client
      t.belongs_to :billing_code
      t.belongs_to :timesheet
      t.datetime :start_date
      t.integer :monday_hours
      t.integer :tuesday_hours
      t.integer :wednesday_hours
      t.integer :thursday_hours
      t.integer :friday_hours
      t.integer :saturday_hours
      t.integer :sunday_hours
      t.timestamps
    end

    create_table :billing_codes do |t|
      t.belongs_to :client
      t.string :code
      t.text :description
      t.timestamps
    end

    create_table :businesses do |t|
      t.string :name
      t.timestamps
    end

    create_table :clients do |t|
      t.string :name
      t.string :code
      t.integer :total_spend
      t.integer :hottest_spend_day
      t.timestamps
    end

    create_table :comments do |t|
      t.string :subject
      t.text :body
      t.timestamps
    end

    create_table :contact_cards do |t|
      t.belongs_to :client
      t.belongs_to :contact, polymorphic: true
      t.timestamps
    end

    create_table :expense_reports do |t|
      t.belongs_to :user
      t.timestamps
    end

    create_table :people do |t|
      t.string :name
      t.timestamps
    end

    create_table :players do |t|
      t.string :name
      t.timestamps
    end

    create_table :positions do |t|
      t.belongs_to :team
      t.belongs_to :player
      t.string :role
      t.timestamps
    end

    create_join_table :billing_codes, :timesheets do |t|
      t.index [:billing_code_id, :timesheet_id], name: "billing_timesheets"
      t.index [:timesheet_id, :billing_code_id], name: "timesheets_billing"
    end

    create_table :sessions do |t|
      t.string :session_id
      t.text :data
      t.timestamps

      t.index :session_id
    end

    create_table :teams do |t|
      t.string :name
      t.string :coach
      t.timestamps
    end

    create_table :timesheets do |t|
      t.belongs_to :user
      t.integer :approver_id
      t.boolean :submitted, :default => false
      t.integer :lock_version, :default => 0
      t.timestamps
    end

    create_table :users do |t|
      t.belongs_to :client
      t.string :login
      t.string :name
      t.string :email
      t.jsonb  :properties
      t.string :password_digest,                 null: false
      t.string :password_reset_token, limit: 60, null: false
      t.string :token
      t.boolean :authorized_approver
      t.datetime :timesheets_updated_at
      t.timestamps
    end
  end
end
