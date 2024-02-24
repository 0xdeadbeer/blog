---
title: "OpenSSL Notes and Resources"
date: 2024-02-24T17:35:10+01:00
---

> **Note:** This article will get updates over time as I continue on reading the source code of the OpenSSL project.

> **Note:** These notes mainly cover the latest version at the time of updating this article. Currently, I am reading: v3.2.1

> **Note:** Notes are provided at my will and convenience. Keep in mind that it takes time for me to take notes and write articles. If you desire an even deeper understanding of the project, you are welcome to read the [source code](https://github.com/openssl/openssl), and if you can, [contributing to this article](https://github.com/0xdeadbeer/blog) would be greatly appreciated.

### Common structs

These are the most common structs you will come accross when reading the source code. 

 - `SSL_CTX`: context for a program. Can be created using `SSL_CTX_new(3)`
 - `SSL` (SSL_CONNECTION) represents a SSL connection (and is created under a context) 
 - `SSL_METHOD`: struct with function pointers that a context inherits and can use when it has to perform an SSL action (connect, read, peek, write, ctrl, etc.)
 - `SSL_SESSION`: 
 - `SSL_CIPHER`: 
---
 - `TLS_client_method`: a SSL_METHOD with client utility function pointers
 - `TLS_server_method`: a SSL_METHOD with server utility function pointers
---
 - `BIO`: struct that can be used to handle program I/O. There are two types of BIOs, source/sink and filter. A BIO can represent an open file, a network socket, a memory buffer, etc. [[1]](https://www.openssl.org/docs/man1.1.1/man7/bio.html) [[2]](https://stackoverflow.com/a/51672134)
 - `BIO_METHOD`: struct with function pointers that a BIO inherits and can use when it has to perform an I/O action (bwrite, bread, bputs, bgets, crtl, etc.)
---

## Resources

 - [Matt Caswell on OpenSSL and Cryptography](https://www.youtube.com/watch?v=RNqlpA1qH64)
 - [RFC: The Transport Layer Security (TLS) Protocol Version 1.2](https://datatracker.ietf.org/doc/html/rfc5246)
 - [RFC: The Transport Layer Security (TLS) Protocol Version 1.3](https://datatracker.ietf.org/doc/html/rfc8446)
 - [RFC: Transport Layer Security (TLS) Extensions: Extension Definitions](https://datatracker.ietf.org/doc/html/rfc6066)


