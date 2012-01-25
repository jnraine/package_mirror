class MirrorsController < ApplicationController
  def download
    @mirror = Mirror.get(params[:id])
    if @mirror.present?
      send_file Mirror::PACKAGE_DIR + @mirror.installer_item_location, :filename => @mirror.download_filename
      fresh_when :etag => @mirror, :last_modified => @mirror.created_at.utc, :public => true
    else
      render page_not_found
    end
  end
end
