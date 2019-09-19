filename="in"
while read -r line; do
    name="$line"
    curl -H "Content-Type: application/json" --request POST --data '{"teamname":"Wannabe_Eves","password":"dsf45eqlcq", "plaintext":"'$name'"}' -k https://172.27.26.163:9000/des
    printf "\n"
done < "$filename"
