# For SOCfinder

loc=""
soc_loc=""
sauce="${loc}/accessions_withdata"

mkdir -p "${loc}/socf"


while read -r r; do

        ${soc_loc}/SOC_mine.py -g ${loc}/data/${r}/*.faa -f ${loc}/data/${r}/*.fna -gff ${loc}/data/${r}/genomic.gff -O ${loc}/socf_aa/${r} -n
        ${soc_loc}/SOC_parse.py -i ${loc}/socf_aa/${r} -k ${soc_loc}/inputs/SOCIAL_KO.csv -a ${soc_loc}/inputs/antismash_types.csv

        echo "SOCfinder for accession ${r} is done."

done < <(tail -n+2 ${sauce})
