class AddAttachmentCheckinPhotoToTeams < ActiveRecord::Migration
  def self.up
    change_table :teams do |t|
      t.attachment :checkin_photo
    end
  end

  def self.down
    remove_attachment :teams, :checkin_photo
  end
end
