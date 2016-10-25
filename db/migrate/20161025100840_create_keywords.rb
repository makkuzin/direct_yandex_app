class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :name, default: "Undefined"
      t.integer :impressions, default: 0
      t.integer :clicks, default: 0
      t.integer :bid, default: 0
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
