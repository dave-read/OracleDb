call azure group create -n Oracle-12c-dr -l southcentralus
call azure group deployment create -f oracle.json -e oracle.dr-site.parameters.json Oracle-12c-dr Oracle-12c-dr