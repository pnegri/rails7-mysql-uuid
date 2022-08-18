class CreateAudits < ActiveRecord::Migration[7.0]
  def change
    create_table :audits, id: :uuid do |t|
      t.string :auditable

      t.timestamps
    end
  end
end
