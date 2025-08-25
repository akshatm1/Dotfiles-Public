#!/bin/bash

pac=$(pacman -Q | wc -l)
aur=$(pacman -Qm | wc -l)

echo "{\"text\":\" $pac($aur)\"}"

