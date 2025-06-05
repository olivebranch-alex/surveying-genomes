sauce=""
loc=""

echo "" > "num.txt"

while read -r r; do
        end_line=$(grep -n "^>" ${loc}/${r}/*.fna | awk -F: 'NR==2 {print $1}')
        if [ -z "$end_line" ]; then
                cp  ${loc}/${r}/*.fna ${loc}/chromosome_fna/${r}.fna
        else
                 head -n "$(($end_line - 1))" ${loc}/${r}/*.fna > ${loc}/chromosome_fna/${r}.fna
               #echo "$(wc -l < ${loc}/${r}/*.fna)" >> "num.txt"

        fi

done < ${sauce}
