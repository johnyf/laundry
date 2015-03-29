#!/usr/bin/python

# retrieve links from "datalink" files themselves under hg version control
# 2011.11.02 Ioannis Filippidis, jfilippidis@gmail.com     
# Python 3

import sys, os, fileinput, fnmatch;

def loadurls(filename):
	linelist = fileinput.input(filename);
	for line in linelist:
		yield line;

def locate(pattern, root=os.curdir):
    '''Locate all files matching supplied filename pattern in and below
    supplied root directory.'''
    for path, dirs, files in os.walk(os.path.abspath(root)):
        for filename in fnmatch.filter(files, pattern):
            yield os.path.join(path, filename)

def download(url, path):
	'''Copy the contents of a file from a given URL
	to a local file.'''
	import urllib.request
	fname = url.split('/')[-1];
	print(url);
	print(fname);
	urllib.request.urlretrieve(url, path +fname.strip() ); # trim newline, if any

if __name__ == '__main__':
	if len(sys.argv) == 1:
		try:
			file_generator = locate("datalink", "./");
			for file in file_generator:
				print("Found file named: ", file);
				url_list = loadurls(file);
				for url in url_list:
					path = file.strip('datalink'); # keep only path
					print(path);
					download(url, path);
		except IOError:
			print('Filename not found.')
