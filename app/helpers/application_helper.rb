module ApplicationHelper

    def asset_exist?(path) #実装前パートナー画像用
        Rails.application.assets.find_asset(path).present?
    rescue
        false
    end
end
