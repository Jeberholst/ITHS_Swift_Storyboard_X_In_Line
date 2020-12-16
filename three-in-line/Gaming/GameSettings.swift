//
//  GameSettings.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-15.
//

import Foundation

class GameSettings {
    
    var listOfPlayers = Array<Player>()
    var rounds = 0
    var squares = (3 * 3)
    
    func addPlayersToList(player: Player){
        listOfPlayers.append(player)
    }
    
    func setRounds(rounds: Int){
        self.rounds = rounds
    }
    
    func addComputerBot(){
        
    }
    
    

    
}
