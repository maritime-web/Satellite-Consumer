#!/bin/bash
# script for consuming satellite images of the coast of Greenland and
# the Baltic Sea
suffixterra="latest.terra.250m.tif"
suffixaqua="latest.aqua.250m.tif"
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
  curl -o "$i.$suffixterra" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=arctic_regions&subset=$i.terra.250m.tif"
  curl -o "$i.$suffixaqua" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=arctic_regions&subset=$i.aqua.250m.tif"
done
echo "Merging Arctic images"
gdal_merge.py -o /data/Greenland.latest.terra.250m.tif *.terra.250m.tif
gdal_merge.py -o /data/Greenland.latest.aqua.250m.tif *.aqua.250m.tif
cd /data
# download for the Baltic Sea
curl -o "BalticSea.$suffixterra" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=BalticSea.terra.250m.tif"
curl -o "BalticSea.$suffixaqua" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=BalticSea.aqua.250m.tif"
# download for Svalbard
curl -o "Hornsund.$suffixterra" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=aeronet&subset=Hornsund.terra.250m.tif"
curl -o "Hornsund.$suffixaqua" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?project=aeronet&subset=Hornsund.aqua.250m.tif"
# download for Canada
curl -o "ARCTAS_Spring_Canada.latest.terra.1km.tif" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=ARCTAS_Spring_Canada.terra.1km.tif"
curl -o "ARCTAS_Spring_Canada.latest.aqua.1km.tif" "https://lance.modaps.eosdis.nasa.gov/imagery/subsets/?subset=ARCTAS_Spring_Canada.aqua.1km.tif"
exit 0
