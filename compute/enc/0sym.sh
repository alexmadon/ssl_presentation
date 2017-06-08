http://www.openssl.org/docs/apps/enc.html
enc - symmetric cipher routines 


Encrypt a file using triple DES in CBC mode using a prompted password: 

 openssl des3 -salt -in file.txt -out file.des3


Encrypt a file using triple DES in CBC mode using a prompted password: 

openssl enc -des3 -salt -k mypassword -in file.txt -out file.des3
openssl enc -des3 -d -salt -in file.des3 -out file_dec.txt -k mypassword

============================

openssl genrsa -out private.pem 1024
openssl rsa -in private.pem -out public.pem -outform PEM -pubout
openssl rsautl -encrypt -inkey public.pem -pubin -in file.txt -out file.ssl

http://stackoverflow.com/questions/7143514/how-to-encrypt-a-large-file-in-openssl-using-public-key

139668914407080:error:0406D06E:rsa routines:RSA_padding_add_PKCS1_type_2:data too large for key size:rsa_pk1.c:151:



head -n 5 file.txt > file2.txt
openssl rsautl -encrypt -inkey public.pem -pubin -in file2.txt -out file.ssl





http://stackoverflow.com/questions/1199058/how-to-use-rsa-to-encrypt-files-huge-data-in-c-sharp
For future searches regarding RSA bad length exceptions...

You can calculate the max number of bytes which can be encrypted with a particular key size with the following:

((KeySize - 384) / 8) + 37

However, if the optimal asymmetric encryption padding (OAEP) parameter is true, the following can be used to calculate the max bytes:

((KeySize - 384) / 8) + 7

The legal key sizes are 384 thru 16384 with a skip size of 8.




((16384- 384) / 8) + 7 =2007

openssl genrsa -out private.pem 16384
openssl rsa -in private.pem -out public.pem -outform PEM -pubout
openssl rsautl -encrypt -inkey public.pem -pubin -in file2.txt -out file.ssl

head --bytes=2000 file.txt > file2.txt





madon@madona:~/ssl/compute$ openssl genrsa -out private.pem 2048
Generating RSA private key, 2048 bit long modulus
.................................................................................+++
.............................................+++
e is 65537 (0x10001)
madon@madona:~/ssl/compute$ openssl genrsa -out private.pem 4096
Generating RSA private key, 4096 bit long modulus
............................++
.........++
e is 65537 (0x10001)
madon@madona:~/ssl/compute$ openssl genrsa -out private.pem 8192
Generating RSA private key, 8192 bit long modulus
..............................................................................................................................................................................................................................++
...........................................................................................................................................................++
e is 65537 (0x10001)


((8192- 384) / 8) + 7
983

head --bytes=983 file.txt > file2.txt




time for i in `seq 1 100`; do openssl rsautl -encrypt -inkey public.pem -pubin -in file2.txt -out file.ssl; done

real	0m0.504s
user	0m0.308s
sys	0m0.116s


time for i in `seq 1 100`; do openssl enc -des3 -salt -k mypassword -in file2.txt -out file.des3; done
real	0m0.436s
user	0m0.004s
sys	0m0.020s


rm file3.txt
for i in `seq 1 100`; do cat file2.txt >> file3.txt ; done
time openssl enc -des3 -salt -k mypassword -in file3.txt -out file.des3