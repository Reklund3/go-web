package main

import (
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
)

//TIP <p>To run your code, right-click the code and select <b>Run</b>.</p> <p>Alternatively, click
// the <icon src="AllIcons.Actions.Execute"/> icon in the gutter and select the <b>Run</b> menu item from here.</p>

func home(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("Received request: at %s\n", r.URL.Path)
	w.Write([]byte("Welcome to the home page!"))
}

func main() {
	r := mux.NewRouter()

	r.HandleFunc("/", home)

	http.ListenAndServe(":8080", r)
}
