package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {

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

	fmt.Println("HTTP server started")

}
