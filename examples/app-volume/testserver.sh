#!/bin/bash
docker run -d -p 9000:80 -v `pwd`/testwars:/www/testwars rossbachp/slidefire 
