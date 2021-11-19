# Deceptive Image -inator
## Crytography Project AY 2020
## Authors
 [Chandan]()
 
 [Harshad_Dhane]()
 
 [Tejashwar_Reddy]()
 
 [Sathvikchandu]()
 
 [Umar_Ahmed]()
 
 [Avinash_Reddy]()

### Introduction
>The process of embedding the secret message bits into some digital mediums like images or audio or videos or text files are known as data hiding. The main purpose of data hiding is the transmission of secret messages from one place to another place by hiding them in a cover medium. If the data hiding process is used for secret message communication, then it will be known as steganography, the receiver will extract the secret message from the cover medium and ignore the cover medium. Similarly, data hiding is also used for data hiding and authentication and copyright protection. To achieve data authentication or copyright protection, a piece of unique information (sequence of bits) known as a watermark will be embedded in a digital medium. Whenever one authorized person wants to claim ownership or wants to authenticate the data he/she can extract the watermark and compare it with the original watermark. 

### Motivation
>In today's world security is a big concern. Instead of sending a gibberish text which is just too simple for someone to find with a good knowledge of cryptanalysis. And it’s easy to say that a text is encrypted. We planned to use an image that leads to less suspicion. The image can be the last place someone would expect data to be hidden. If you are sending messages through text, people know that it is a conversation and start to decrypt them. But what are the odds of finding out there is a text message hiding in an image having a nice image of a person as to its cover?. This facility made us more curious about the concept and has driven us in building this project. 

### Proposed scheme
>In this proposed scheme data hiding inside the cover image is done through reversible data hiding in natural images. Here we use a popular technique known as histogram shifting based on reversible data hiding, where we shift the pixel values of the original image by analyzing its histogram and hiding our data accordingly. After embedding the message in the image, we use a keystream generated by RC4 to encrypt the image. The receiver also uses the same keystream to decrypt the image.

### Data Hiding
>reversible data hiding (RDH) has emerged into a new class of data hiding methods that enables exact retrieving of both embedded data and cover medium. In the present study, a novel automatic RDH method with contrast enhancement is proposed, in which the data is embedded through two-sided histogram expansion.

### Image Encryption (RC4)
>The RC4 encryption algorithm, developed by RSA's Ronald Rivers, is a shared key encryption algorithm that requires a secure exchange of shared keys. The symmetric key algorithm is used in the same way for encryption and decryption, so the data stream is simply XOR-linked with the generated key sequence. 

### Algorithm 

#### Data Hiding in Image
- Input a grayscale image I.
- Resize the image into 512 x 512 pixels.
- Find Histogram H of image I and peak intensity value Pk from H.
- Increment all pixels > Pk && pixels < 255 by 1.
- Generate a random sequence of 0s and 1s as our data equal to the frequency of the maximum pixel value.
- If databit == 1 Increment the current pixel > Pk by 1.
- Else databit == 0 No change in the pixel value.
- Repeat the loop until all the bits are embedded.
- Take output as a Stego Image.

#### Image encryption & decryption
- Take the image that should be encrypted or decrypted as input.
- Take the key as input
- Encryption
  - Convert the image into a single list of pixels
  - Convert the pixels into binary and concat into a one long string
  - XOR each bit of the pixels string with the keystream generated by RC4()
  - Convert the binary value back to decimals.
  - Use the pixels to construct the encrypted image.
- Decryption
  - Convert the image into a single list of pixels
  - Convert the pixels into binary and concat into a one long string
  - XOR each bit of the pixels string with the keystream generated by RC4()
  - Convert the binary value back to decimals.
  - Use the pixels to construct the decrypted image.

#### Data extraction and Image recovery
- Take input of the decrypted image E.
- Generate an array of size = Height of the original histogram with all zeros.
- If Current pixel value == Pk
   - Extract 0 from the pixel value 
 - else Current pixel value == (Pk+1)
   -  Extract 1 from the pixel value
- Add all the data in the array generated earlier.
- Decrement all the pixel values > Pk by 1.
- Output is a completely recovered image with the array as the data embedded.


[Click Here](https://github.com/Harshad141/Cryptography-Project-/blob/main/main/dataembeeding.m) Matlab Code for Data Hiding

[Click Here](https://github.com/Harshad141/Cryptography-Project-/blob/main/rc4_image_enc_dec/main.py) Code for RC4 encryption and decryption

[Click Here](https://github.com/Harshad141/Cryptography-Project-/blob/main/main/dataextraction.m) Matab Code for Data Extraction and Image recovery

[Click Here](https://docs.google.com/document/d/1lmmgEhA9WMnA067-5jw6M4XKtbfJFlnJKL-v2i_PVj4/edit?usp=sharing) For full project report


