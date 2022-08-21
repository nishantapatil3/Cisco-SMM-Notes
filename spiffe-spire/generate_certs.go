package main

import (
        "time"
        "os"
        // "encoding/gob"
        "encoding/pem"
        "math/big"
        "crypto/x509"
        "crypto/x509/pkix"
        "fmt"
        "crypto/rsa"
        "crypto/rand"
)

func main() {

    // ok, lets populate the certificate with some data
    // not all fields in Certificate will be populated
    // see Certificate structure at
    // http://golang.org/pkg/crypto/x509/#Certificate
    template := &x509.Certificate {
             IsCA : true,
             BasicConstraintsValid : true,
             SubjectKeyId : []byte{1,2,3},
             SerialNumber : big.NewInt(1234),
             Subject : pkix.Name{
                       Country : []string{"Earth"},
                       Organization: []string{"Mother Nature"},
             },
             NotBefore : time.Now(),
             NotAfter : time.Now().AddDate(5,5,5),
             // see http://golang.org/pkg/crypto/x509/#KeyUsage
             ExtKeyUsage : []x509.ExtKeyUsage{x509.ExtKeyUsageClientAuth, x509.ExtKeyUsageServerAuth},
             KeyUsage : x509.KeyUsageDigitalSignature|x509.KeyUsageCertSign,
    }

    // generate private key
  	privatekey, err := rsa.GenerateKey(rand.Reader, 4096)

  	if err != nil {
  		fmt.Println(err)
  	}

  	publickey := &privatekey.PublicKey

  	// create a self-signed certificate. template = parent
  	var parent = template
  	derBytes, err := x509.CreateCertificate(rand.Reader, template, parent, publickey, privatekey)

  	if err != nil {
  		fmt.Println(err)
  	}

  	// this will create plain text PEM file.
  	keyfile, _ := os.Create("key.pem")
  	var keypem = &pem.Block{
  		Type : "PRIVATE KEY",
  		Bytes : x509.MarshalPKCS1PrivateKey(privatekey)}
  	pem.Encode(keyfile, keypem)
  	keyfile.Close()

    certfile, _ := os.Create("cert.pem")
  	var certpem = &pem.Block{
  		Type : "CERTIFICATE",
  		Bytes : derBytes}
  	pem.Encode(certfile, certpem)
  	certfile.Close()

}
