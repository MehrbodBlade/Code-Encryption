import os
from Crypto.Cipher import AES
from Crypto.Protocol.KDF import PBKDF2
from Crypto.Random import get_random_bytes
from Crypto.Util.Padding import pad, unpad

AES_KEY_SIZE = 32  # 256 bits
PBKDF2_ITERATIONS = 100000

def generate_aes_key(password, salt):
    # Derive a 256-bit AES key from the password using PBKDF2
    key = PBKDF2(password, salt, dkLen=AES_KEY_SIZE, count=PBKDF2_ITERATIONS)
    print(f"Generated AES key: {key.hex()}")
    return key

def aes_encrypt(data, key):
    cipher = AES.new(key, AES.MODE_CBC)
    ciphertext = cipher.encrypt(pad(data, AES.block_size))
    return cipher.iv + ciphertext

def aes_decrypt(encrypted_data, key):
    iv = encrypted_data[:16]
    ciphertext = encrypted_data[16:]
    cipher = AES.new(key, AES.MODE_CBC, iv)
    return unpad(cipher.decrypt(ciphertext), AES.block_size)

def process_files_in_directory(input_dir, output_dir, choice, password):
    if not os.path.exists(input_dir):
        print(f"Input directory '{input_dir}' does not exist.")
        return

    os.makedirs(output_dir, exist_ok=True)

    for filename in os.listdir(input_dir):
        file_path = os.path.join(input_dir, filename)
        if os.path.isfile(file_path):
            with open(file_path, 'rb') as file:
                file_data = file.read()

            salt = get_random_bytes(16)
            key = generate_aes_key(password, salt)

            if choice == 'e':
                encrypted_data = aes_encrypt(file_data, key)
                processed_data = salt + encrypted_data
                output_filename = f'encrypted_{filename}'
            else:
                salt = file_data[:16]
                encrypted_data = file_data[16:]
                key = generate_aes_key(password, salt)
                decrypted_data = aes_decrypt(encrypted_data, key)
                processed_data = decrypted_data
                output_filename = f'decrypted_{filename}'

            output_path = os.path.join(output_dir, output_filename)
            with open(output_path, 'wb') as output_file:
                output_file.write(processed_data)

            print(f"Processed {filename} and saved as {output_filename}")

def main():
    choice = get_user_choice()

    input_dir = 'input'
    output_dir = 'result'

    password = input("Enter the password for encryption/decryption: ")

    process_files_in_directory(input_dir, output_dir, choice, password)

def get_user_choice():
    while True:
        choice = input("Do you want to encrypt or decrypt the files? (e/d): ").lower()
        if choice in ['e', 'd']:
            return choice
        print("Invalid choice. Please enter 'e' for encrypt or 'd' for decrypt.")

if __name__ == "__main__":
    main()
