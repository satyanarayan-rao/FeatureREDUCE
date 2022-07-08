#!/bin/bash
# $1 : original SELEX table
# $2 : output featureREDUCE compatible file
# $3 : tf_id to put as label
cut -f2,4 $1 | awk '{if (NR==1){print "TF_Id\tArrayType\t"$0}else{print v"\tSELEX\t"$0}}' v=$3  | tr -d '"' > $2 
