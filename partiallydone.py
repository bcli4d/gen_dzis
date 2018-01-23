#!/usr/bin/env python

from __future__ import print_function
import os
from subprocess import call

def get_partials():

    with open('found.txt','w') as f:
        call(['gsutil','ls','gs://imaging-west-dzis/*/'],stdout=f)    
    with open('found.txt') as f:
        founds = f.read().splitlines()
        
    with open('partials.txt','w') as partials:
        i = 0
        while i<len(founds):
            print(founds[i])
            if founds[i+2].find(founds[i][0:-1]) == 0 :
                i += 4
            else:
                partials.write(founds[i][0:-1]+'\n')
                if founds[i+1].find(founds[i][0:-1]) == 0 :
                    i += 3
                else:
                    i += 2
    
if __name__ == '__main__':
    get_partials()
