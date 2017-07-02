class CreateAdminBanners < ActiveRecord::Migration
  def change
    create_table :admin_banners do |t|
      t.boolean :active
      t.text :banner

      t.timestamps
    end
  end
end
