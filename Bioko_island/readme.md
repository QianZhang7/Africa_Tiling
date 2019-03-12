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


## Figure 1: the Maps: levelplots for raster maps to show the original population surfaces
https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/plot_raster3.R

Please note: in this code, MCDI has been plotted by using its shapefile format, but you can also try the above rasterize script and plot it as a raster map.


## Figure 2: the CDFs vs area plot:
https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/compare_pop_3.R

## Figure 2b : Pdf
Coming soon

## Figure 3 Topology: Blob Analysis

The function for blob analysis is: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/blob_analysis_function.R

And the code for the plots is: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/blob_analysis_all.R

The blob analysis of 100m WorldPOP is still under calculation. It needs to be run in parallel on a cluster. I will upload the scripts later.
