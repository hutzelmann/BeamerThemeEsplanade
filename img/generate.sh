#!/bin/sh

(cd .. && latexmk -pdf example.tex)
pdftocairo -r 72 -png ../example.pdf ./example
