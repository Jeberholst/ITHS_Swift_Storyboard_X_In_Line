//
//  GameModes.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-21.
//

import Foundation

class GameModes {
    
    private var listOfModes: [GameMode]
    
    init() {
        listOfModes = [GameMode]()
        addGameModes()
    }
    
    func getListCount() -> Int {
        return listOfModes.count
    }
    
    func getList() -> [GameMode]{
        return listOfModes
    }
    
    private func addGameModes() {
        listOfModes.append(GameMode(name: "3 in-line, 3 x 3", columns: 3))
        listOfModes.append(GameMode(name: "4 in-line, 4 x 4", columns: 4))
        listOfModes.append(GameMode(name: "5 in-line, 5 x 5", columns: 5))
    }
}
