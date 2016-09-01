class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      # Completa con las columnas que necesites
      t.boolean :complete, default: false
      t.string :name
    end
  end
end
