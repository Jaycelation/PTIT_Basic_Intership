import rsalib

a = rsalib.gen_prime(512)
b = rsalib.gen_prime(512)
c = rsalib.gen_prime(512)
print(f'a + b = {a + b}')
print(f'a - b = {a - b}')
print(f'a * b = {a * b}')
print(f'a / b = {a / b}')
print(f'a ^ b mod c = {rsalib.mod_pow(a, b, c)}')