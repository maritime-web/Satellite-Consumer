#!/bin/bash
# script for consuming satellite images of the coast of Greenland and
# the Baltic Sea
yesterday=$(date +%Y%j --date="1 day ago")
places[0]="Academy_Glacier"
places[1]="Geickie_Plateau"
places[2]="Helheim_Area"
places[3]="Humboldt_and_Petermann_Glacier"
places[4]="JakobshavnIsbrae"
places[5]="Kangerdlugssuaq"
places[6]="Koge_Bugt"
places[7]="Melville_Coast"
places[8]="Northeast_Region"
places[9]="North_Region"
places[10]="Nuuk"
places[11]="Scoresby_Sund"
places[12]="Southeast_Region"
places[13]="South_Region"
places[14]="Southwest_Region"
places[15]="Thule"
places[16]="Uummannaq"
cd /data
for i in "${places[@]}"
do
  curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=arctic_regions&subset=$i.$yesterday.terra.250m.tif"
done
cd /data
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=BalticSea.$yesterday.terra.250m.tif"
exit 0
