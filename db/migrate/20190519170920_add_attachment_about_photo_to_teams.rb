class AddAttachmentAboutPhotoToTeams < ActiveRecord::Migration
  def self.up
    change_table :teams do |t|
      t.attachment :about_photo
    end
  end

  def self.down
    remove_attachment :teams, :about_photo
  end
end
