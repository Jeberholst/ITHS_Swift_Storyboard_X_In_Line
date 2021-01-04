//
//  GameSettings.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-15.
//

import Foundation

class GameSettings {
  
    var turn: Int = 0
    var round: Int = 0
    
    func changeTurn(){
        if self.turn == 0 {
            self.turn = 1
        }else{
            self.turn = 0
        }
    }
    
    func calcNonTurn() -> Int {
        switch turn {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func increaseRound(){
        self.round += 1
    }
    
}
