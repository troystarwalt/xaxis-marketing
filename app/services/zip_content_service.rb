require 'zip'

class ZipContentService
  def initialize(files)
    @files = files
  end

  def zip_files_please
    stringio = Zip::OutputStream.write_buffer do |out|
      @files.each do |enter|
        path = enter.file_identifier
        out.put_next_entry(path)
        out.write enter.file.read
      end
    end
    stringio.rewind
    return stringio.read
  end

end
