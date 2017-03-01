class AddUsersLogoUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :logo_url, :string
  end
end
