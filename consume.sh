#!/bin/bash
# script for consuming satellite images of the coast of Greenland and
# the Baltic Sea
function checkFileSizes {
  echo "Checking for images that are not actually images"
  for f in *.tif
  do
    size=$(wc -c <$f)
    if [ $size -lt 1000 ]; then
      echo "Deleting $f because it is not an image"
      rm $f
    fi
  done
}
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
cd /tmp
# download for the coast of Greenland
for i in "${places[@]}"
do
  curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=arctic_regions&subset=$i.$yesterday.terra.250m.tif"
  curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=arctic_regions&subset=$i.$yesterday.aqua.250m.tif"
done
echo "Merging Arctic images"
gdal_merge.py -o /data/Greenland.$yesterday.terra.250m.tif *.terra.250m.tif
gdal_merge.py -o /data/Greenland.$yesterday.aqua.250m.tif *.aqua.250m.tif
cd /data
# download for the Baltic Sea
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=BalticSea.$yesterday.terra.250m.tif"
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=BalticSea.$yesterday.aqua.500m.tif"
# download for Svalbard
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=aeronet&subset=Hornsund.$yesterday.terra.250m.tif"
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=aeronet&subset=Hornsund.$yesterday.aqua.250m.tif"
# download for Canada
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=ARCTAS_Spring_Canada.$yesterday.terra.1km.tif"
curl -O -L -J "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=ARCTAS_Spring_Canada.$yesterday.aqua.1km.tif"
checkFileSizes
exit 0
