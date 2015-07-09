# ATTENTION: mkvirtualenv --always-copy
# to avoid symlinked include/python2.7 that requires sudo
venvname=dev

set -e
which bison
which flex
pip install mercurial
mkdir -p temp
cd temp

# =================
# install SIP4
# =================

# link found from:
#    http://www.riverbankcomputing.com/software/sip/download
if [ -d "sip" ]; then
    echo "sip already cloned."
else
    hg clone http://www.riverbankcomputing.com/hg/sip
fi
# installation instructions here:
#    http://pyqt.sourceforge.net/Docs/sip4/installation.html
cd sip
python build.py prepare
python configure.py --incdir ~/.virtualenvs/$venvname/include/python2.7/
time make
make install
cd ../

# ================
# install PyQt4
# ================

# download link found here:
#    http://www.riverbankcomputing.com/software/pyqt/download
select=mac # or x11
if [ -d "PyQt-mac-gpl-4.11.1" ]; then
	echo "PyQt already downloaded."
else
	curl -LO http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.1/PyQt-$select-gpl-4.11.1.tar.gz
	tar vzxf PyQt-*.tar.gz
fi
# http://pyqt.sourceforge.net/Docs/PyQt4/installation.html
cd PyQt-*

# alternative:
# curl -LO http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.1/PyQt-mac-gpl-4.11.1.tar.gz
#
echo "yes" | python configure-ng.py
time make
make install

# install dev packages
pip install -r requirements.txt
