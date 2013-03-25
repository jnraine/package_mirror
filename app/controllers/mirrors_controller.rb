class MirrorsController < ApplicationController
  def download
    @mirror = Mirror.get(params[:id])
    if @mirror.present? and @mirror.installer_item_location.present?
      send_file Mirror.packages_dir + @mirror.installer_item_location, :filename => @mirror.download_filename
      fresh_when :etag => @mirror, :last_modified => @mirror.created_at.utc, :public => true
    else
      render page_not_found
    end
  end
end
