class CreateTicketItems < ActiveRecord::Migration
  def change
    create_table :ticket_items do |t|
      t.references :ticket, index: true, foreign_key: true
      t.references :ticket_type, index: true, foreign_key: true
      t.integer :qty

      t.timestamps null: false
    end
  end
end
