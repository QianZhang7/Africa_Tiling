# R Scripts for Accuracy Metrics for Human Population Distribution Maps 

## Data and Format

We have 5 database: MCDI(1lm, 100m), WorldPOP(1km, 100m) and Landscan(1km)

MCDIs are shapefiles (.shp) and all others are raster maps. To read these database, please see:
https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/read_all_data.R

Please note: the Bioko island area has been 'croped' from the global maps in Landscan and Worldpop
All the data has been saved in an Rdata in our google drive.


In following steps, we need the raster format of MCDI population surface, but the raster grids and the shapefile polygons
can't be perfectly matched, so I coded https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/correct_rasterize.R
to rasterize it correctly.


##
