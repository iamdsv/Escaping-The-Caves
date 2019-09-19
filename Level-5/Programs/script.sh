for i in $(cat < "inputs.txt")
do
curl -H "Content-Type: application/json" --request POST --data '{"teamname":"Wannabe_Eves","password":"dsf45eqlcq", "plaintext":"'"$i"'"}' -k https://172.27.26.163:9000/eaeae >> outputs.txt
done
