class CreatePetsApplication < ActiveRecord::Migration[5.2]
  def change
    create_table :pets_applications do |t|
      t.references :pet, foreign_key: true
      t.references :application, foreign_key: true
    end
  end
end
