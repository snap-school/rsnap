module ChapterMissionManifestHelper
  def chapter_missions_path(chapter)
    if :id 
      "/chapter_missions/#{chapter.id}/"
    else
      '/chapter_missions/'
    end
  end
  def add_chapter_missions_path(chapter, mission=nil)
    if mission.nil?
      if :id
        "/chapter_missions/#{chapter.id}/add_mission/"
      else
        '/chapters/'
      end
    else
      "/chapter_missions/#{chapter.id}/add_mission/#{mission.id}"
    end
  end
  def remove_from_chapter_path(chapter,mission)
    manifest = ChapterMissionManifest.find_by(:chapter_id => chapter.id, :mission_id => mission.id)
    "/chapter_mission_manifest/#{manifest.id}"
  end
end
