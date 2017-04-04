class AddYoutubeVideoIdToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :youtube_video_id, :string
  end
end
