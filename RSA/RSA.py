import rsalib

with open('flag.txt', 'r') as file:
    flag = file.read()

p = rsalib.gen_prime(512)
print(f'p = {p}')
q = rsalib.gen_prime(512)
print(f'q = {q}')

e = 65537
n = p * q

phi = (p-1) * (q-1)

c = rsalib.encrypt(flag, e, n)
print(f'Encrypted flag = {c}')

d = rsalib.mod_invert(e, phi)
print(f'd = {d}')

decrypted_flag = rsalib.decrypt(c, d, n)
print(f'Decrypted flag: {decrypted_flag}')