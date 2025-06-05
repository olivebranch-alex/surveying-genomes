# Obtaining MLST data, concatenation

loc=""
sauce="${loc}/accession_ecoli"
dataloc="${loc}/data_cds"
mlstloc="${loc}/mlst_NA"
refloc="${loc}/mlst_NA/reference/EcoliRef"
psauce="${mlstloc}/proteinids"


while read -r r; do

        mkdir -p ${mlstloc}/${r}
        hpc pgcbioinfo/blast:2.9.0 blastn -query ${dataloc}/${r}/*.fna -db ${refloc} -out ${mlstloc}/${r}/${r}_blast.tsv  -outfmt "6 qseqid sseqid pident length evalue qseq" -evalue 1e-05 -num_threads 16
        concat_prop="${mlstloc}/${r}/${r}_concat"
        fullSeq=""
        while read -r protID; do

                toAdd=$(grep "${protID}" "${mlstloc}/${r}/${r}_blast.tsv" | awk '{print $3, $6}' | sort -nr | head -n 1 | cut -d ' ' -f 2-)
                toAdd+="NNNNNN"
                fullSeq+="${toAdd}"

        done < ${psauce}
        echo "${fullSeq}" > ${concat_prop}      

done < <(tail -n+2 ${sauce})
