#!/bin/bash

#definition des arguments

depart=$1
arrive=$2
taille=$3

#fonction qui cree un dossier nome arrive s il existe pas. s il exite ne fais rien

function creedossier {
  mkdir -p $arrive
}

#fonction qui copie que les fichiers tipe image depuis le 1er argument au 2eme argument

function copie {
  for file in $depart/* ; do
  if [[ $("file" --mime-type -b "$file") == image/* ]]; then
    cp -r "$file" $arrive
  else
    echo "$file n est pas une image"
  fi
done
}

#fonction qui nettoie les noms des images dans le repertoire d arrive

function rename {
  for file in $arrive/* ; do
    mv "$file" $(echo "$file" | tr -d " " | tr -d "'" | tr -d '"' | tr -d "*" | tr -d ".")
  done
}

#fonctiooooon qui verifie l existance d un 3eme argument, s il existe un utilise la commande qui resize, sinon, on utilise l autre
#les deux changent l extention, et supprimment le double

function format {
    if [ -z "$taille" ]; then
	for file in $arrive/* ; do
	    convert "$file" "$file.png"
	    rm "$file"
	done
    else
	for file in $arrive/* ; do
	    convert "$file" -resize $taille "$file.png"
	    rm "$file"
	done
    fi
}

#appel des fonctions

creedossier
copie
rename
format
