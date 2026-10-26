class CoverUploader < CarrierWave::Uploader::Base
  # Картинки не обрабатываем: сохраняем как загрузили
  storage :file

  # public/uploads/post/cover/<id>
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png webp]
  end

  # Проверяем и тип содержимого, чтобы под .jpg не загрузили что-то другое
  def content_type_allowlist
    %r{image/(jpeg|png|webp)}
  end
end
