require "aws-s3-deploy/version"

module AwsS3Deploy
  include Rake::DSL if defined? Rake::DSL

  def install_tasks
    desc "Deploy via S3"
    task :s3 do

      page = s3.list_objects(bucket: bucket_name)

      p "deleting content"
      loop do
        page.contents.each do |ob|
          s3.delete_object bucket: bucket_name, key: ob.key
        end
        break unless page.next_page?
        page = page.next_page
      end

      p "uploading _site"

      traverse_directory(local_dir).flatten.compact.each do |f|
        key = f.gsub(local_dir+"/", "")
        ext = File.extname(f)
        if file_types.keys.include? ext
          upload_compressed_object(key, f, ext)
        else
          upload_object(key, f, ext)
        end
      end

      p "s3 deploy complete"
    end

    # Shamelessly copied from
    # https://gist.github.com/rrevanth/9377cb1f1664bf610e38#file-rakefile-L43
    # https://github.com/stereobooster/jekyll-press/issues/26
    desc "Minify site"
    task :minify do
      puts "\n## Compressing static assets"
      original = 0.0
      compressed = 0
      Dir.glob("_site/**/*.*") do |file|
        case File.extname(file)
        when ".css", ".gif", ".html", ".jpg", ".jpeg", ".js", ".png", ".xml"
          puts "Processing: #{file}"
          original += File.size(file).to_f
          min = Reduce.reduce(file)
          File.open(file, "w") do |f|
            f.write(min)
          end
          compressed += File.size(file)
        else
          puts "Skipping: #{file}"
        end
      end
      puts "Total compression %0.2f\%" % (((original-compressed)/original)*100)
    end
  end
end

AwsS3Deploy.install_tasks
