#!/bin/bash

# El bucle repite el mismo comando para cada valor de K:
for K in 2 3 4 5 6; do
   # Només executa admixture si l'arxiu .log no existix:
   if [ ! -e cf6.$K.log ]; then
      # L'opció "--cv" instruix admixture que execute la validació creuada.
      # Amb el ">" redirigisc els missatges d'admixture a un arxiu .log.
      admixture --cv ../data/cf6.bed $K > cf6.$K.log
   fi
done

# Amb les ordres següents extrec els resultats de les validacions
# creuades a un arxiu "CVsummary.txt", fàcil de llegir en R.
if [ ! -e CVsummary.txt ]; then
   echo "K CV.error" > CVsummary.txt
   grep "CV error" *.log | \
   cut -d "=" -f 2 | \
   sed 's/)://'  >> CVsummary.txt
fi
