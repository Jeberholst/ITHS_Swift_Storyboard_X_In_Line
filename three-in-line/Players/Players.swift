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
