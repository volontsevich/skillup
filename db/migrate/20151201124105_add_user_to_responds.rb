class AddUserToResponds < ActiveRecord::Migration
  def change
    add_reference :responds, :user, index: true, foreign_key: true
  end
end
