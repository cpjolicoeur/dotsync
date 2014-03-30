require_relative './dotsync'

dotsync_config = YAML::load(File.open('./test.yml'))
ConfigFile.destination_folder_path = dotsync_config['destination_path']

dotsync_config['dotfiles'].each do |dotfile|
  source_path = dotfile['source_path']
  destination_name = dotfile['destination_name']
  description = dotfile['dotfile_name']
  ignored_files = dotfile['ignored_files']
  ConfigFile.new(source_path, destination_name, description, ignored_files).sync_files
end
