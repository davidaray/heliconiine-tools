sed -i 's/;//g' $1
sed -i 's/))//g' $1
sed -i 's/((//g' $1
sed -i 's/)(//g' $1
sed -i 's/()//g' $1
sed -i "s/')//g" $1
sed -i "s/('//g" $1
sed -i "s/'//g" $1
sed -i 's/,/\n/g' $1
sed -i 's/hMel /hMel_/g' $1
sed -i 's/hEra /hEra_/g' $1

#awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < $2

IFS=$'\n'; for i in $(cat $1);do  line=$(grep -nr "$i" $2); if [[ ! -z $line ]];then for j in $line;do lineNumber=$(echo $j | cut -d':' -f1); sed -n "$lineNumber p" $2; awk -v nb=$lineNumber 'NR > nb {if ($0 ~ ">") exit; else print $0 }' $2; done;fi;done > $1".fas"

#/lustre/work/daray/software/muscle/muscle -in $2"_"$1.fas -out $2"_"$1.muscle.fas -gapopen -2.9 -gapextend 0 -hydrofactor 1.2 -maxmb 597 -maxiters 8 -cluster1 upgmb -cluster2 upgmb -diaglength 24 -verbose -seqtype Protein
