//
//  Player.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

class Player {
    
    var name: String
    var points: [Int]
    var rounds: [Int]
    var marker: SquareVal
    var selectedSquares = Array<Int>()
    var isComputerBot: Bool = false
    
    init(name: String, points: Array<Int>, rounds: Array<Int>, marker: SquareVal) {
        self.name = name
        self.points = points
        self.rounds = rounds
        self.marker = marker
    }
    
    func totalScore() -> Int {
        //TODO : Sum points array
       // var total = list.map({$0.points}).reduce(0, +)
        //total from list with specific element
        
        //let total = points.red(into: 0, 1)
        return 0
    }
    
    func addPointAndCurrRound(point: Int, currRound: Int){
        points.append(point)
        rounds.append(currRound)
    }
    
    func setResetSelectionSize(count: Int) {
        selectedSquares = Array(repeating: 0, count: count)
        print("SelectedSquareSize \(selectedSquares)")
    }
    
    
}
