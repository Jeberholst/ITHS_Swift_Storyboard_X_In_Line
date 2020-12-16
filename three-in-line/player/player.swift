//
//  Player.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

struct Player {
    
    var name: String,
    points: Array<Int>,
    round: Array<Int>,
    isComputerBot: Bool = false
    
    init(name: String, points: Array<Int>, round: Array<Int>) {
        self.name = name
        self.points = points
        self.round = round
    }
    
    func totalScore() -> Int {
        //TODO : Write function
        return 0
    }
    
}
