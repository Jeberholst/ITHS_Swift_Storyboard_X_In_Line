//
//  Squares.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

class Squares {
    private var list: [Square]
    
    init() {
        list = [Square]()
        //TODO: ADD AS INPUT VARIABLE?
        addInitialSquares(amount: 9)
    }
    
    private func addInitialSquares(amount: Int){
        let squaresToAdd = (1...amount)
        
        squaresToAdd.forEach { i in
            let sq = Square(index: i, checked: false)
            print(sq)
            addASquare(square: sq)
        }
        
    }
    
    func addASquare(square: Square){
        list.append(square)
    }
    
    func getList() -> [Square] {
        return list
    }
    
}
