module SnapAssetsHelper
  def snap_all_assets
    snap_translations.merge(snap_backgrounds)
      .merge(snap_costumes)
      .merge(snap_sounds)
      .merge(snap_help)
      .merge(snap_libraries)
  end

private
  def snap_translations
    files = list_dir("", "lang-*.js")
    list_assets(files)
  end

  def snap_backgrounds
    files = list_dir("Backgrounds/", "*")
    list_assets(files)
      .merge("Backgrounds" => list_dir("Backgrounds/", "*", true))
  end

  def snap_costumes
    files = list_dir("Costumes/", "*")
    list_assets(files)
      .merge("Costumes" => list_dir("Costumes/", "*", true))
  end

  def snap_sounds
    files = list_dir("Sounds/", "*")
    list_assets(files)
      .merge("Sounds" => list_dir("Sounds/", "*", true))
  end

  def snap_help
    files = list_dir("help/", "**/*.png")
    list_assets(files)
  end

  def snap_libraries
    files = list_dir("Backgrounds/", "*")
    list_assets(files)
      .merge("Backgrounds" => list_dir("Backgrounds/", "*", true))
  end

  def list_dir(dir, accepted_regexp, only_file = false)
    files = Dir.glob("#{Rails.root}/lib/assets/javascripts/snap-byob/" + dir + accepted_regexp)
    files.map do |f|
      f.split("#{Rails.root}/lib/assets/javascripts/snap-byob/#{dir if only_file}")[1]
    end
  end

  def list_assets(files, asset_path_method = :asset_path)
    assets = Hash.new
    files.each do |f|
      assets[f] = send(asset_path_method, "snap-byob/#{f}")
    end
    assets
  end
end
