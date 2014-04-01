dotsync
====================

Usage
------------
Create **dotsyncrc.yml** in the **home** directory


Installation
------------
	gem install instagram


Code
--------------
example configuration

    destination_path: /Users/jaychae/Developers/Personal/vim-dotfiles
    dotfiles:
      -
        description: Vim bundles
        source_path: /Users/jaychae/.vim
        destination_name: vim-bundles
        ignored_files: bundles
      -
        description: vimrc
        source_path: /Users/jaychae/.vimrc
        destination_name: vimrc
        ignored_files:
