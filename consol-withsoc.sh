# Consolidation of amrfinderplus and socfinder results 

socrloc="${loc}/socf_aa"
sauce="${loc}/consolidated/accessions_withdata"
locsauce="${loc}/data/contigloc.csv"


mkdir -p "${loc}/consolidated"

while read -r r; do 

        output_csv="${loc}/consolidated/${r}_consol.csv"
        echo "Accession, Protein ID, Location, Social, Contig ID, Element Symbol, Element Name, Class, Module" > ${output_csv}
        while IFS='\t' read -r line; do
                proteinID=""
                contigID=""
                elementsymbol=""
                elementname=""
                class=""
                social=""
                location=""
                module=()
                
                
                proteinID=$(echo "${line}" | awk -F'\t' '{print $1}')
                contigID=$(echo "${line}" | awk -F'\t' '{print $2}')
                elementsymbol=$(echo "${line}" | awk -F'\t' '{print $6}')
                elementname=$(echo "${line}" | awk -F'\t' '{print $7}')
                class=$(echo "${line}" | awk -F'\t' '{print $11}')
                social=$(grep -q "${proteinID}" "${socrloc}/${r}/SOCKS.csv"; echo $?)
                location=$(grep "${contigID}" "${locsauce}" | awk -F"," '{print $2}')

                if grep -iq "${proteinID}" "${socrloc}/${r}/B_SOCK.csv"; then
                        module+=("B ")
                fi 
                if grep -iq "${proteinID}" "${socrloc}/${r}/K_SOCK.csv"; then   
                        module+=("K ")
                fi 
                if grep -iq "${proteinID}" "${socrloc}/${r}/A_SOCK_filtered.csv"; then
                        module+=("A ")
                fi
                if [ ${#module[@]} -eq 0 ]; then
                        module+=("NA")
                fi

                echo "${r}, ${proteinID}, ${location}, ${social}, ${contigID}, ${elementsymbol}, ${elementname}, ${class}, ${module}" >> ${output_csv}

        done < <(tail -n+2 "${amrloc}/${r}")
done < <(tail -n+2 "${sauce}")
