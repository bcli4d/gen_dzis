#!/usr/bin/env python

from __future__ import print_function
import os
from subprocess import call

DEST='gs://imaging-west-dzis/'

def get_skips():
    with open('skip.tsv') as f:
        skips = f.read().splitlines()
    return skips

'''
def get_dones():
    dones = get_skips()
    
    with open('done.txt','w') as f:
        call(['gsutil','ls','gs://imaging-west-dzis/*/*.dzi'],stdout=f)    

    with open('done.txt') as f:
        done_dzis = f.read().splitlines()
        for d in done_dzis:
            done = d.split('/')[3]+'/'+d.split('/')[4]
            done = done.rsplit('.',1)[0]
            dones.append(done)
    return dones    
'''

def get_dones():
    dones = get_skips()
    
    with open('done.txt','w') as f:
        call(['gsutil','ls','-d','gs://imaging-west-dzis/*/*_files'],stdout=f)    

    with open('done.txt') as f:
        done_dzis = f.read().splitlines()
        for d in done_dzis:
            done = d.split('/')[3]+'/'+d.split('/')[4]
            done = done.rsplit('_files',1)[0]
            dones.append(done)
    print(dones[0])
    return dones    
    
def get_slides(slidelist):
    with open(slidelist) as f:
        svss = f.read().splitlines()
        slides = []
        for slide in svss:
            s = slide.split('/')[9] + '/' + slide.split('/')[10]
            s = s.rsplit('.',1)[0]
            slides.append(s)
        return slides

def get_notdones(slides,dones):
    with open('notdone.tsv','w') as notdone:
        notdone.write('--env BASE\t--input INPUT_FILE\n')
        for slide in slides:
            if slide not in dones:
                notdone.write(slide+'\t'+'gs://imaging-west/'+slide+'.svs\n')

def run(slidelist):
    slides = get_slides(slidelist)
    dones = get_dones()
    get_notdones(slides,dones)
    
           
if __name__ == '__main__':
    run('diagnostic_images.txt')
