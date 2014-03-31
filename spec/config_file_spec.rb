require_relative '../dotsync'
require_relative './spec_helper'


describe ConfigFile do
  before do
    ConfigFile.destination_folder_path = "/Users/jaychae/Developers/Personal/vim-dotfiles"
    @config_file = ConfigFile.new("/Users/jaychae/.vim", "vim-bundles", "Vim Bundles", ["bundles"])
  end

  context 'instance methods' do
    describe '#full_destination_path' do
      it 'should return be concantenation of destionation_folder_path and destination_name' do
        full_path = "/Users/jaychae/Developers/Personal/vim-dotfiles/vim-bundles"
        @config_file.full_destination_path.should == full_path
      end
    end

    describe '#sync_files' do
      before do
        ret_val = ["/Users/jaychae/.vim/bundles", "/Users/jaychae/.vim/lolcat"]
        Dir.stub(:glob).with(anything()).and_return(ret_val)
      end

      it 'should create a path in the desetination folder' do
        FileUtils.stub(:cp_r)
        File.stub(:exist?).and_return(false)
        FileUtils.stub(:mkdir_p)
        FileUtils.should_receive(:mkdir_p).once
        @config_file.sync_files
      end

      xit 'should raise a LoadError if the destionation_folder_path is nil' do
        ConfigFile.stub(:destination_folder_path).and_return(nil)
        expect { @config_file.sync_files }.to raise_error(LoadError)
      end 
    end
  end

  context 'class methods' do
    describe '##destionation_folder_path=' do
      it 'should remove the trailing slash if it exists' do
        ConfigFile.destination_folder_path = '/foo/foo1/'
        ConfigFile.destination_folder_path.should == '/foo/foo1'
      end
    end
  end
end
