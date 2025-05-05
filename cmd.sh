#!/bin/bash

setup() {
    printer "🔨 Setting up the repo"
    git submodule update --init --recursive
    handler
}

policies() {
    printer "📚 Generating documentation"
    case $2 in
        privacy)
            pandoc ./policies/md/Privacy_Policy.md \
            -o ./policies/Privacy_Policy.pdf \
            --template=./pandoc-latex-template/template-multi-file/eisvogel.latex \
            --pdf-engine=xelatex
            handler
            ;;
        cookie)
            pandoc ./policies/md/Cookie_Policy.md \
            -o ./policies/Cookie_Policy.pdf \
            --template=./pandoc-latex-template/template-multi-file/eisvogel.latex \
            --pdf-engine=xelatex
            handler
            ;;
        *)
            echo "Usage: $0 policies {privacy|cookie}"
            ;;
    esac
}

printer() {
    echo ""
    echo $1
    echo ""
}

handler() {
    if [ $? -eq 0 ]; then
        printer "✅ Process completed successfully"
    else
        printer "❌ An error occurred during the process"
        exit 1
    fi
}

case $1 in
    setup)
        setup
        ;;
    policies)
        policies $@
        ;;
    *)
        echo "Usage: $0 {setup|policies}"
        ;;
esac

scimmia
