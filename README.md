# SimulAT
A program to  generate eight million virtual people in Austria 

## Background
Given a set of public or privat available demographic data about a real population, it should be possible to generate a virtual population which is congruent to the demographhic data in sense of statistic distribution.

## How it works
Don't know yet!

## Data Preparation 

1. Sort Demographic data by Lat and Lon fields.
2. Set index for every raster record
3. Sort Eichamt data by Lat and Lon fields

```
latestAddressWithBiggerLat = 0
for raster in demographicrecords
  currentRasterLat = raster[Lat]
  for i = latestAddressWithBiggerLat; i < length(eichamtRecords); i++
    currentAddressLat = address[i][Lat];
    if currentAddressLat < currentRasterLat
      latestAddressWithBiggerLat = address[id]
    else 
```

    
