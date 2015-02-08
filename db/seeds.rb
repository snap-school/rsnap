# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

chapters = Chapter.create([{title: "En voiture...", description: "Mouvement
Nous allons ici introduire deux blocs: le bloc \"avancer de 10 pas\" et le bloc \"se diriger en faisant un angle de 90\".
En mettant le bon nombre de pas dans le bloc “avancer” tu devrais arriver au premier tournant
Il faut maintenant tourner vers le haut, pour cela prend un bloc \"se diriger en faisant un angle de 90\" et sélectionne le bon angle pour aller vers le haut.
Ajoute-le en-dessous du reste de ton programme et ta voiture tourne maintenant vers le haut quand elle arrive au bout de la ligne droite.

Ce n'est pas encore tout à fait la fin, il faut encore avancer jusqu’au-dessus, puis tourner et encore avancer pour aller jusqu’à la ligne d’arrivée.", small_description: " Pour cette mission tu vas prendre place dans un bolide et tenter de rejoindre la ligne d’arrivée dans ta voiture. ", youtube: "BhWQDFSTXSQ"}])
