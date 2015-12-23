class AddStatusAndPublisherToEvents < ActiveRecord::Migration
  def change
    add_column :events, :status, :string
    add_reference :events, :user, index: true, foreign_key: true
  end
end
