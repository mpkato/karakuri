namespace :backup do

  desc "backup dump"
  task :dump do
    on roles(:app), in: :groups, limit: 3 do
      within current_path do
        with rails_env: :production do
          filename = "config/database.yml"
          config = YAML::load(File.open(filename))["production"]
          timestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
          backup_file = "#{shared_path}/tmp/backups/#{timestamp}_dump.sql.gz"
          command = "mysqldump -u #{config['username']} -p`echo $KARAKURI_DATABASE_PASSWORD` #{config['database']} | gzip -c > #{backup_file}"
          execute command
        end
      end
    end
  end

end
