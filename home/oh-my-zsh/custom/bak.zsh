function bak() {
    if [[ -z $1 ]]; then
        echo "$0 - Create a .bak backup of a file"
        echo "Usage: $0 file"
        return 1
    fi
    cp $1 $1.bak
}

