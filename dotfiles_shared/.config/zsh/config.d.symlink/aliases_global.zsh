alias -g  C="| wc --lines"
alias -g  H="| head --lines 25"
alias -g  I="| add-index --input-type list  --print-indexables | set-index-variables"
alias -g  T="| tail --lines 25"
alias -g BC="| awk --field-separator : '{print \$1}'" # print whatever is before the first colon
alias -g EX="| grep -v "
alias -g IF="| add-index --input-type mixed --print-indexables | set-index-variables"
alias -g IT="| add-index --input-type tree  --print-indexables | set-index-variables"
alias -g LC="| awk '{print \$NF}'" # print last column
alias -g FC="| awk '{print \$1}'" # print first column

alias -g AWSEXPORT="| jq '.Credentials.AccessKeyId, .Credentials.SecretAccessKey, .Credentials.SessionToken, .Credentials.Expiration, .AssumedRoleUser.Arn' --raw-output | paste --delimiters='\0' <( echo 'export AWS_ACCESS_KEY_ID=\nexport AWS_SECRET_ACCESS_KEY=\nexport AWS_SESSION_TOKEN=\nexport AWS_SESSION_EXPIRATION=\nexport AWS_ROLE_ARN=') -"

alias -g HELP="--help | bat --plain --language=help"
