#!/bin/bash
# This script splits a pdf file into pages as separate pdf files.
# @author gnagy
# @date 20/Jan/2018.
# Parameters:
#     $1 is the input file
#     output files will be named "inputfile_p{PAGE_NUMBER}.pdf"

PDF_FILE_TO_SPLIT=$1
PDF_FILE_NAME=`basename $PDF_FILE_TO_SPLIT .pdf`

function split_pdf_to_pages {
  echo Processig $PDF_FILE_TO_SPLIT
  local maxPage=$(determine_pdf_max_page_number $PDF_FILE_TO_SPLIT)
  for i in `seq 1 $maxPage`;
    do      
      `gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
         -dFirstPage=$i -dLastPage=$i \
         -sOutputFile=${PDF_FILE_NAME}-$i.pdf ./$PDF_FILE_TO_SPLIT`
         echo Page $i is split.
    done
}

function determine_pdf_max_page_number {
  echo $(gs -q -dNODISPLAY -c "($1) (r) file runpdfbegin pdfpagecount = quit";)
}

split_pdf_to_pages
