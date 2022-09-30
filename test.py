python
from pwn import *
import hashlib

conn = remote("blackhat4-ac66ee1bbf6d6edd64a68636b170b110-0.chals.bh.ctf.sa", 443, ssl=True, sni="blackhat4-ac66ee1bbf6d6edd64a68636b170b110-0.chals.bh.ctf.sa")
#conn = process(["python3", "task1.py"])
conn.recvuntil("...")
conn.recvuntil("|")
conn.sendline(" ")
conn.recvuntil("public key ::")
conn.recvline()
idd = str(conn.recvline().strip().decode().split(' = ')[-1])
conn.recvuntil("enjoy ::")
conn.recvline()
enc_flag = int(conn.recvline().strip().decode().split('    ')[-1])

while True:
    conn.recvuntil("> ")
    conn.sendline("e")
    conn.recvuntil("> (int) ")
    conn.sendline(str(2**512))
    conn.recvuntil("Encryption ::")
    conn.recvline()
    m1 = int(conn.recvline().strip().decode().split('    ')[-1])
    m2 = int(conn.recvline().strip().decode().split('    ')[-1])
    conn.recvuntil("> ")
    conn.sendline("d")
    conn.recvuntil("> (int) ")
    conn.sendline(str(m1))
    conn.recvuntil("Decryption ::")
    conn.recvline()
    r = int(conn.recvline().strip().decode().split('    ')[-1])
    conn.recvuntil("> ")
    conn.sendline("d")
    conn.recvuntil("> (int) ")
    conn.sendline(str(m2))
    conn.recvuntil("Decryption ::")
    conn.recvline()
    q = int(conn.recvline().strip().decode().split('    ')[-1])
    n = (2**512 - r) // q
    if str(hashlib.sha256(str(n).encode()).hexdigest()) == str(idd):
            break

print("Modulus : ",n)

while True:
    conn.recvuntil("Key updated succesfully ::")
    conn.recvline()
    conn.recvline()
    #print(conn.recvline().strip().decode().split(' = ')[-1])
    #e=55
    e = int(conn.recvline().strip().decode().split(' = ')[-1])
    print(e % 0x10001)
    if e % 0x10001 == 0:
        print("SOLVED")
        _e = e//0x10001
        new_c = pow(enc_flag, _e, n)
        conn.recvuntil("> ")
        conn.sendline("d")
        conn.recvuntil("> (int) ")
        conn.sendline(str(new_c))
        conn.recvuntil("Decryption ::")
        conn.recvline()
        FLAG = bytes.fromhex(hex(int(conn.recvline().strip().decode().split('    ')[-1]))[2:])
        print(FLAG)
        exit()
    conn.sendline("u")
