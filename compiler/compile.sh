#!/bin/bash
export CHEZSCHEMELIBDIRS=.:../compiler:../../duck-compiler/
cd build && scheme --script ../compiler/$1 $2 $3