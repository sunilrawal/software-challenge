#!/bin/bash
f=$(pwd)

sips --resampleWidth 29 "${f}/${1}" --out "${f}/Icon-29.png"
sips --resampleWidth 58 "${f}/${1}" --out "${f}/Icon-29@2x.png"
sips --resampleWidth 87 "${f}/${1}" --out "${f}/Icon-29@3x.png"

sips --resampleWidth 40 "${f}/${1}" --out "${f}/Icon-40.png"
sips --resampleWidth 80 "${f}/${1}" --out "${f}/Icon-40@2x.png"
sips --resampleWidth 120 "${f}/${1}" --out "${f}/Icon-40@3x.png"

sips --resampleWidth 120 "${f}/${1}" --out "${f}/Icon-60@2x.png"
sips --resampleWidth 180 "${f}/${1}" --out "${f}/Icon-60@3x.png"

sips --resampleWidth 76 "${f}/${1}" --out "${f}/Icon-76.png"
sips --resampleWidth 152 "${f}/${1}" --out "${f}/Icon-76@2x.png"

