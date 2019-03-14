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

## Figure: Scatter plots for population comparison, by pixel

https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/compare_scatter_plot.R

## Figure: the CDFs vs area plot:
https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/compare_pop_3.R

## Figure: Pdf
Coming soon

## Figure Topology: Blob Analysis

The function for blob analysis is: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/blob_analysis_function.R

And the code for the plots is: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/blob_analysis_all.R

The blob analysis of 100m WorldPOP is still under calculation. It needs to be run in parallel on a cluster. I will upload the scripts later.

## Figure Pfpr surface

To get the levelplot and histograms for Pfpr, please see https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/raster_pr.R

To get the levelplot and histograms for population-weighted pfpr, please see
https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/pr_weighted_matched.R

## Parallel computing to get the huge adjacency matrix for neighbouring information

R script: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/big_adj_col.R
Sh script: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/big_adj.sh

To run it, please use commands ('{1..1000'} can be changed to loop though al the pixels in the raster map):
for i in {1..1000}; do qsub -P proj_mmc big_adj.sh $i; done


## Others

MST-based clustering for small size shapefile: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/adjacent.R

Visualize MST-based clusters: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/compare_mst.R

Convert all data into points and save as csv files: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/convert_to_csv.R

Using R/leaflet for visualziation: https://github.com/QianZhang7/Africa_Tiling/blob/master/Bioko_island/leaflet.R

