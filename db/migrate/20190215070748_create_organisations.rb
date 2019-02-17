class CreateOrganisations < ActiveRecord::Migration[5.2]
  def change
    create_table :organisations do |t|
      t.string :name
      t.decimal :rate
      t.references :user, foreign_key: true

      t.timestamps
    end

  end
end
