#!/bin/bash

set -e
shopt -s globstar

for binderpath in binder*; do
    echo "binderpath ${binderpath}"
    find "${binderpath}" -type f ! \( -name "cnorm=log+num-generations=4096+surface-size=256+viz=site-ingest-depth-by-rank-heatmap+ynorm=linear+ext=.png" -o -name "*viz=site-reservation-by-rank-spliced-at-heatmap+ext=.png" -o -name "*.pdf" -o -name "*.tex" -o -name "*.bib" \) -exec rm -f {} +
done

rm -rf binder/teeplots/0*
rm -rf binder/teeplots/{10,21,30,40}

# copy symlinks, see https://stackoverflow.com/a/17882368/17332200
cp -rL implemented_pseudocode implemented_pseudocode_copy
rm -rf implemented_pseudocode
mv implemented_pseudocode_copy implemented_pseudocode

find . -type f -name '*.jpg' -exec rm -f {} +
find . -type d -name dishtiny -exec rm -rf {} +
find . -type d -name hstrat -exec rm -rf {} +
find . -type d -name conduit -exec rm -rf {} +
find . -type d -name docs -exec rm -rf {} +
find . -type d -empty -delete

rm -f arxiv.tar.gz
git checkout bibl.bib
make cleaner
make
make clean
mv bibl.bib main.bib
cp bu1.bbl main.bbl
cp bu1.blg main.blg
tar -czvf arxiv.tar.gz *
