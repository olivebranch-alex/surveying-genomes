# For fastGEAR

loc=""
fgloc=""
mcrloc=""
sauce="${loc}/uniqueelementnames.txt"
alignment="" # Alignments of resistance genes

mkdir -p ${loc}/amrgenes

while read -r gene; do
        echo "running fastGEAR for ${gene}"
        mkdir -p "${loc}/amrgenes/${gene}"

        hpc pgcbioinfo/fastgear:latest run_fastGEAR.sh ${mcrloc} "${alignment}/${gene}.fasta" "${loc}/amrgenes/${gene}/fgout.mat" "${loc}/fgspecs.txt" 

done < ${sauce}
