//
//  Players.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

class Players {
    
    private var list: [Player]

    init(){
        list = [Player]()
        
        let player1 = Player(name: "Player 1", points: [Int](), rounds: [Int](), marker: SquareVal.X)
        let player2 = Player(name: "Player 2", points: [Int](), rounds: [Int](), marker: SquareVal.O)
        self.addPlayer(player: player1)
        self.addPlayer(player: player2)
    }
    
    func addPlayer(player: Player){
        list.append(player)
    }
    
    func getList() -> [Player]{
        return self.list
    }
    
    func setResetAllSelections(count: Int){
        for player in list {
            player.setResetSelectionSize(count: count)
        }
    }
    //
}
