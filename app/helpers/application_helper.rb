module ApplicationHelper

  # Checks availability of an asset both in dev (sprockets server) and production (precompiled manifest).
  def asset_exist?(path) # 実装前パートナー画像用
    if Rails.configuration.assets.compile
      Rails.application.assets&.find_asset(path).present?
    else
      manifest = Rails.application.assets_manifest
      manifest&.assets&.key?(path) || manifest&.files&.values&.any? { |v| v['logical_path'] == path }
    end
  rescue
    false
  end
end
