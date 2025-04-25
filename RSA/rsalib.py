import random
import math
# Miller-Rabin check prime number
def is_prime(n, k = 5):
    if n <= 1 or n == 4:
        return False
    if n <= 3:
        return True

    d = n - 1
    r = 0
    while d % 2 == 0:
        d //= 2
        r += 1

    for _ in range(k):
        a = random.randrange(2, n - 2)
        x = pow(a, d, n)

        if x == 1 or x == n - 1:
            continue

        for _ in range(r - 1):
            x = pow(x, 2, n)
            if x == n - 1:
                break
        else:
            return False

    return True

# Gen prime number k (bits)
def gen_prime(bits):
    while True:
        candidate = random.getrandbits(bits) | (1 << bits - 1) | 1
        if is_prime(candidate):
            return candidate
        
# Calc mod invert in RSA
def mod_invert(e, phi):
    def extended_gcd(a, b):
        if a == 0:
            return b, 0, 1
        gcd, x1, y1 = extended_gcd(b % a, a)
        x = y1 - (b // a) * x1
        y = x1
        return gcd, x, y
    
    gcd, x, _ = extended_gcd(e, phi)
    if gcd != 1:
        raise ValueError("Modular inverse does not exist")
    return (x % phi + phi) % phi

# Calc pow
def mod_pow(base, exponent, modulus):
    result = 1
    base = base % modulus
    while exponent > 0:
        if exponent & 1:
            result = (result * base) % modulus
        base = (base * base) % modulus
        exponent >>= 1
    return result

# Convert 
def int2text(number):
    length = (number.bit_length() + 7) // 8  
    return number.to_bytes(length, byteorder='big').decode('utf-8')
    
def text2int(text):
    return int.from_bytes(text.encode('utf-8'), byteorder='big')

# Decrypt
def decrypt(c, d, n):
    return int2text(mod_pow(c, d, n))

# Encrypt
def encrypt(flag, e, n):
    m = text2int(flag)
    return mod_pow(m, e, n)