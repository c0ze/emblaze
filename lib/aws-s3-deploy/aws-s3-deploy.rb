require "aws-s3-deploy/version"

module AwsS3Deploy
  def local_dir; './_site'; end

  def access_key; ENV['AWS_ACCESS_KEY']; end
  def secret_key; ENV['AWS_SECRET_KEY']; end
  def region;  ENV['AWS_REGION']; end
  def bucket_name;  ENV['AWS_BUCKET_NAME']; end

  def file_types
    { ".html" => { type: "text/html" },
      ".css" => { type: "text/css" },
      ".js" => { type: "application/javascript" }
    }
  end

  def traverse_directory(path)
    Dir.entries(path).map do |f|
      next if [".", ".."].include? f
      f_path = File.join(path, f)
      if File.directory? f_path
        traverse_directory f_path
      else
        f_path
      end
    end
  end

  def gzip(data)
    sio = StringIO.new
    gz = Zlib::GzipWriter.new(sio)
    gz.write(data)
    gz.close
    sio.string
  end

  def upload_compressed_object(key, f, ext)
    s3.put_object bucket: bucket_name,
                  key: key,
                  body: gzip(File.read(f)),
                  acl: "public-read",
                  content_type: file_types[ext][:type],
                  content_encoding: "gzip",
                  cache_control: "max-age=604800"
  end

  def upload_object(key, f, ext)
    s3.put_object bucket: bucket_name,
                  key: key,
                  body: File.open(f),
                  acl: "public-read",
                  cache_control: "max-age=604800"
  end

  def s3
    @s3 = Aws::S3::Client.new(
      region: region,
      credentials: Aws::Credentials.new(access_key, secret_key)
    )
  end
end
