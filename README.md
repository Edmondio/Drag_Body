
# DRAGBODY




## FR

Ce script modifié de dragbody pour FiveM sous ESX vise à améliorer deux aspects liés à 

l'interaction avec les joueurs dans le jeu, notamment lorsqu'ils sont morts.


Corrections apportées :

    Remise au sol après le drag :
    Le script assure désormais que lorsqu'un joueur est traîné (drag) par un autre
    joueur après sa mort, il est correctement remis au sol une fois le drag terminé.
    Cela évite les comportements indésirables où le joueur traîné reste suspendu dans
    les airs.

    Modification de ESX AmbulanceJob :
    Une modification a été apportée à ESX AmbulanceJob pour éviter le chevauchement des
    compteurs lorsqu'un joueur est mort. Cela garantit une expérience de jeu plus 
    fluide et cohérente pour les joueurs et les secouristes.


## Modification sur esx_ambulancejob

Ligne 357 : Replace

    AddEventHandler('esx:onPlayerDeath', function(data)
      OnPlayerDeath()
    end)

Par :

    AddEventHandler('esx:onPlayerDeath', function(data)
      ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
            if not isDead then
                      OnPlayerDeath()
            end
        end)
    end)

Ligne 33 

En dessous de la ligne :

     SetEntityHealth(PlayerPedId(), 0)

Ajouter : 

    OnPlayerDeath()


## EN

This modified Drag_Body script for FiveM under ESX aims to enhance two aspects related

to player interaction in the game, especially when they are dead.


Corrections Made:

    Ground placement after dragging:
    The script now ensures that when a player is dragged by another player after death
    they are properly placed back on the ground once the drag is completed. This
    prevents undesirable behaviors where the dragged player remains suspended in the
    air.

    Modification of ESX AmbulanceJob:
    A modification has been made to ESX AmbulanceJob to avoid counter overlap when a
    player is dead. This ensures a smoother and more consistent gaming experience for
    both players and paramedics.


## Modification on esx_ambulancejob

Line 357: Replace

    AddEventHandler('esx:onPlayerDeath', function(data)
      OnPlayerDeath()
    end)

By :

    AddEventHandler('esx:onPlayerDeath', function(data)
      ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
            if not isDead then
                      OnPlayerDeath()
            end
        end)
    end)

Line 33 

Below the line:

     SetEntityHealth(PlayerPedId(), 0)

Add :

    OnPlayerDeath()








