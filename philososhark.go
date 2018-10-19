package main

import (
	"fmt"
	"os/exec"
)

const _cowsay = "/bin/cowsay"
const _fortune = "/bin/fortune"

const _quotes = "/usr/share/philososhark/sharkquotes"

func main() {
	cmd := exec.Command(_fortune, _quotes)

	quote, err := cmd.CombinedOutput()
	if err != nil {
		panic(err)
	}
	quoteStr := fmt.Sprintf("%s", quote)

	cmd = exec.Command(
		_cowsay,
		"-f",
		"shark",
		quoteStr)
	out, err := cmd.CombinedOutput()
	if err != nil {
		panic(err)
	}

	fmt.Printf("%s", out)
}
