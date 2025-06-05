# Using AMRFinderPlus

loc=""
sauce=""
mkdir -p ${loc}/amr


while read r; do

        amrfinder -p ${loc}/data/${r}/*.faa -g ${loc}/data/${r}/genomic.gff -n ${loc}/data/${r}/*.fna --threads 16 -O Escherichia --plus -o ${loc}/amr/${r} 

done < <(tail -n +2 "${sauce}")
