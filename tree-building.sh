# Tree building using MLST data

# Determining best model for data
loc=""
${loc}/modeltest-ng-static -i "${loc}/output.fasta" -p 32 -d nt -o "${loc}/modeltest_output"

# Using RAxML

hpc nanozoo/raxml-ng:1.1.0--dc37ef0 raxml-ng --msa "output.fasta.raxml.reduced.phy.raxml.rba" --model GTR+I+G4 --prefix GTRwithtree --threads 32 --seed 2
hpc nanozoo/raxml-ng:1.1.0--dc37ef0 raxml-ng --support --tree GTRwithtree.raxml.bestTree --bs-trees GTRresult.raxml.bootstraps --prefix GTRsupport --threads 32
