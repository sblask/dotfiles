alias -g  C="| wc --lines"
alias -g  H="| head --lines 25"
alias -g  I="| add-index --input-type list  --print-indexables | set-index-variables"
alias -g  T="| tail --lines 25"
alias -g BC="| awk --field-separator : '{print \$1}'" # print whatever is before the first colon
alias -g IF="| add-index --input-type mixed --print-indexables | set-index-variables"
alias -g IT="| add-index --input-type tree  --print-indexables | set-index-variables"
alias -g LC="| awk '{print \$NF}'" # print last column
