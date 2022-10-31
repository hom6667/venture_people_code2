class CreateBadwordfilters < ActiveRecord::Migration[7.0]
  def change
    create_table :badwordfilters do |t|
      t.text :word_list
      t.timestamps
    end
  end
end
