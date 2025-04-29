package main

import (
	"bytes"
	"log"
	"net/http"
)

func main() {

	var (
		buf    bytes.Buffer
		logger = log.New(&buf, "logger: ", log.Lshortfile)
	)

	mux := http.ServeMux{}
	s := http.Server{
		Addr:    ":8080",
		Handler: &mux,
	}

	mux.Handle("/", http.FileServer(http.Dir(".")))
	err := s.ListenAndServe()
	if err != nil {
		log.Fatal(err)
	}

	logger.Print("HTTP server started")

}
