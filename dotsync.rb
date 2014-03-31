require 'yaml'

class ConfigFile
  attr_accessor :source_path, :destination_name, :description

  def initialize(source_path, destination_name, description, ignored_files)
    @source_path = source_path
    @destination_name = destination_name
    @description = description
    @ignored_files = ignored_files || Array.new #pats relative to the source_path
  end

  def sync_files
    raise LoadError unless self.class.destination_folder_path

    if File.directory?(@source_path)
      sync_folder
    else
      sync_single_file
    end
  end

  def self.dotsync_yaml_config_file
    "#{File.expand_path("~")}/dotsyncrc.yml"
  end

  def self.execute
    dotsync_config = YAML::load(File.open(dotsync_yaml_config_file))
    self.destination_folder_path = dotsync_config['destination_path']

    dotsync_config['dotfiles'].each do |dotfile|
      source_path = dotfile['source_path']
      destination_name = dotfile['destination_name']
      description = dotfile['dotfile_name']
      ignored_files = dotfile['ignored_files']
      self.new(source_path, destination_name, description, ignored_files).sync_files
    end
  end

  def full_destination_path
    "#{self.class.destination_folder_path}/#{@destination_name}" 
  end

  def self.destination_folder_path=(path)
    @@destination_folder_path = path
    @@destination_folder_path.chop! if path[-1] == '/'
  end

  def self.destination_folder_path
    @@destination_folder_path
  end

  private

  def sync_single_file
    FileUtils.cp(source_path, full_destination_path)
  end
  
  def sync_folder
    FileUtils.mkdir_p("#{full_destination_path}") unless File.exist?(full_destination_path)
    Dir.glob("#{source_path}/*").each do |file|
      next if @ignored_files.include?(File.basename(file))
      FileUtils.cp_r("#{file}", "#{full_destination_path}/#{File.basename(file)}")
    end
  end
end


if __FILE__ == $0
  dotsync_config = YAML::load(File.open('./test.yml'))
  ConfigFile.destination_folder_path = dotsync_config['destination_path']

  dotsync_config['dotfiles'].each do |dotfile|
    source_path = dotfile['source_path']
    destination_name = dotfile['destination_name']
    description = dotfile['dotfile_name']
    ignored_files = dotfile['ignored_files']
    ConfigFile.new(source_path, destination_name, description, ignored_files).sync_files
  end
end
