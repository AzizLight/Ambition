class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, :null => false
      t.string :body, :null => false

      t.timestamps
    end
  end
end
