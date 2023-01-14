# Move prompt to the bottom
printf '\n%.0s' {1..100}

# Add a newline ("\n") before each prompt, except for the first one
precmd() {
    # This outer function simply redefines the precmd handler so that subsequent
    # calls will print out the blank line.
    precmd() {
        echo
    }
}
