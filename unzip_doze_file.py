#!/usr/bin/python3

import os
import sys
from zipfile import PyZipFile

def recursive_chown(path, owner, directoryPermission, filePermission):
    for dirpath, dirnames, filenames in os.walk(path):
        os.chown(dirpath, owner, owner)
        os.chmod(dirpath, directoryPermission)
        for filename in filenames:
            os.chown(os.path.join(dirpath, filename), owner, owner)
            os.chmod(os.path.join(dirpath, filename), filePermission)

def main ():
    fileName = sys.argv[1]
    newDirectory = fileName.split('.')[0]

    os.chdir(os.getcwd())

    print("extracting zip {fileName} to {newDirectory}".format(fileName=fileName, newDirectory=newDirectory))
    PyZipFile(fileName).extractall()

    print("changing permissions on {newDirectory}".format(newDirectory=newDirectory))
    os.chown(newDirectory, 1002, 1002)
    os.chmod(newDirectory, 0o775)

    recursive_chown(newDirectory, 1002, 0o775, 0o664)

    print("done")

if __name__ == "__main__":
    main()
