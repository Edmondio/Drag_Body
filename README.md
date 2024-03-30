[FR]

Description du Script Drag_Body pour FiveM sous ESX

Ce script modifié de dragbody pour FiveM sous ESX vise à améliorer deux aspects liés à l'interaction avec les joueurs dans le jeu, notamment lorsqu'ils sont morts.
Corrections apportées :

    Remise au sol après le drag :
        Le script assure désormais que lorsqu'un joueur est traîné (drag) par un autre joueur après sa mort, il est correctement remis au sol une fois le drag terminé. Cela évite les comportements indésirables où le joueur traîné reste suspendu dans les airs.

    Modification de ESX AmbulanceJob :
        Une modification a été apportée à ESX AmbulanceJob pour éviter le chevauchement des compteurs lorsqu'un joueur est mort. Cela garantit une expérience de jeu plus fluide et cohérente pour les joueurs et les secouristes.

Objectif :

L'objectif principal de ces modifications est d'améliorer l'expérience de jeu des utilisateurs de FiveM en corrigeant des problèmes de gameplay et en optimisant les fonctionnalités existantes.
Comment utiliser :

Pour intégrer ces modifications dans votre serveur FiveM :

    Assurez-vous d'avoir accès au code source de votre serveur FiveM.

    Remplacez les fichiers concernés par ceux fournis dans ce dépôt.

    Redémarrez votre serveur FiveM pour appliquer les modifications.

Notes :

    Ce script est destiné à être utilisé avec ESX et peut nécessiter des ajustements supplémentaires en fonction de la configuration spécifique de votre serveur.

    Assurez-vous de tester les modifications dans un environnement de développement avant de les déployer sur un serveur en production.


[EN]

This modified Drag_Body script for FiveM under ESX aims to enhance two aspects related to player interaction in the game, especially when they are dead.

Corrections Made:

    Ground placement after dragging:
    The script now ensures that when a player is dragged by another player after death, they are properly placed back on the ground once the drag is completed. This prevents undesirable behaviors where the dragged player remains suspended in the air.

    Modification of ESX AmbulanceJob:
    A modification has been made to ESX AmbulanceJob to avoid counter overlap when a player is dead. This ensures a smoother and more consistent gaming experience for both players and paramedics.

Objective:

The primary goal of these modifications is to improve the gaming experience of FiveM users by addressing gameplay issues and optimizing existing features.

How to Use:

To integrate these modifications into your FiveM server:

    Ensure you have access to the source code of your FiveM server.
    Replace the relevant files with those provided in this repository.
    Restart your FiveM server to apply the changes.

Notes:

    This script is intended for use with ESX and may require additional adjustments depending on your server's specific configuration.
    Make sure to test the modifications in a development environment before deploying them to a production server.
