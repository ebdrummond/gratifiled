desc "Clear old files from the database and s3"
task :clear_expired_files => :environment do
  Fileshare.clear_expired_files
end