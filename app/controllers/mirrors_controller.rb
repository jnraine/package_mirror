class MirrorsController < ApplicationController
  def download
    @mirror = Mirror.get(params[:id])
    if @mirror.present? and @mirror.installer_item_location.present?
      send_file Mirror.packages_dir + @mirror.installer_item_location, :filename => @mirror.download_filename
      fresh_when :etag => @mirror, :last_modified => @mirror.created_at.utc, :public => true
    else
      if @mirror.blank?
        Rails.logger.error("Package mirror instance for package #{params[:id]} is returning nil. There may be something wrong with the package on the master munkiserver.")
      elsif @mirror.installer_item_location.blank?
        Rails.logger.error("Package mirror instance for package #{params[:id]} is returning nil for installer_item_location. Ensure the installer_item_location is set for this package on the master munki server.")
      end

      render page_not_found
    end
  end
end
