#!/bin/sh
#
########## JOB OUTPUT HEADER ##########
#
#___INFO__MARK_BEGIN__
#
#___INFO__MARK_END__
#
########## GRID ENGINE PARAMETERS ##########
#
#$ -m b
#
########## BEGIN EXECUTION OF R SCRIPT ##########
#
/usr/local/R-current/bin/Rscript /ihme/homes/qianzh/denominators/big_adj_col.R $1
#
########## End of Shell Wrapper for R jobs ##########
