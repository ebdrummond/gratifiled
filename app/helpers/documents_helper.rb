module DocumentsHelper

  def formatted(file_size)
    "#{file_size/1000.0} KB"
  end
end