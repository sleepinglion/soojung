# encoding: utf-8

class GalleryUploader < CarrierWave::Uploader::Base
  
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  #include CarrierWave::WebP::Converter
  # Choose what kind of storage to use for this uploader:
  #storage :file
  #storage :fog
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    upload_dir="#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    unless Rails.env.production?
      upload_dir='uploads/'+upload_dir 
    end
    
    return upload_dir
  end
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  
  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  def scale(width, height)
    # do something
  end
  
  # Create different versions of your uploaded files:
  version :small_thumb do
    process :resize_to_fill => [100, 100]
  end
  
  version :medium_thumb do
    process :resize_to_fill => [200, 200]
  end
  
  version :large_thumb do
    process :resize_to_fill => [400, 300]
  end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
  %w(jpg jpeg gif png)
  end
  
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
end
