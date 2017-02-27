call azure group create -n Oracle-12c-primary -l northcentralus
call azure group deployment create -f oracle.json -e oracle.primary-site.parameters.json Oracle-12c-primary Oracle-12c-primary