//
//  Player.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

struct Player {
    
    var name: String
    var points: [Int]
    var rounds: [Int]
    var marker: String
    var isComputerBot: Bool = false
    
    init(name: String, points: Array<Int>, rounds: Array<Int>, marker: String) {
        self.name = name
        self.points = points
        self.rounds = rounds
        self.marker = marker
    }
    
    func totalScorBe() -> Int {
        //TODO : Sum points array
       // var total = list.map({$0.points}).reduce(0, +)
        //total from list with specific element
        
        //let total = points.red(into: 0, 1)
        return 0
    }
    
    mutating func addPointAndCurrRound(point: Int, currRound: Int){
        points.append(point)
        rounds.append(currRound)
    }
    
    func scoreList(){
        
    }
    
}
