#!/bin/bash
# $1 : featureREDUCE compatible selex table
# $2 : train part
# $3 : test part
# $4 : test template

tot=`wc -l $1 | awk '{print $1}'` 
head -1 $1 > ${2}.h.tsv
frac=`echo "scale =3;${tot} * 0.1" | bc | awk '{print int($1)}'`
seq 1 $tot | shuf -n $frac | sort -k1,1n  > ${3}.frac.tsv
seq 1 $tot | shuf -n $frac | python scripts/make_true_dict.py ${3}.frac.pkl
sed -n '2,$ p' $1 | awk '{print NR"\t"$0}'| python scripts/select_lines_with_first_col_as_key.py ${3}.frac.pkl | cut -f2-  | cat ${2}.h.tsv - > $3 
sed -n '2,$ p' $1 | awk '{print NR"\t"$0}'| python scripts/discard_lines_with_first_col_as_key.py ${3}.frac.pkl | cut -f2- | cat ${2}.h.tsv - > $2
awk '{OFS="\t"}{if (NR==1){print $0}else{$NF="?"; print $0}}' $3 > $4 

# cleanup
rm ${2}.h.tsv ${3}.frac.pkl 
