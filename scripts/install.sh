# Install script for Previous, tested under Ubuntu 16
# Adapted from: http://previous.alternative-system.com/index.php/build

# install C++ compiler, cmake, subversion and library
sudo apt-get install g++
sudo apt-get install cmake
sudo apt-get install subversion
sudo apt-get install zlib1g-dev
sudo apt-get install libpng-dev

# (please note that on a new ubuntu installed machine, apt-get may be locked until all other package managers are running... wait a bit...)
# create a build dir
mkdir previous

# For ubuntu 14.04 and above (SDL2 is already a package):
sudo apt-get install libsdl2-dev

# get latest source code from sourceforge (branch branch_realtime) (this is a single line):
svn checkout svn://svn.code.sf.net/p/previous/code/branches/branch_realtime previous-code

cd previous-code
./configure
make
