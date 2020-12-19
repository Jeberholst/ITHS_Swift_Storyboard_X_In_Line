//
//  Square.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

class Square {
   
    var index: Int
    var checked: Bool
    var finalized: Bool
    var squareVal: SquareVal = .EMPTY
    
    init(index: Int, checked: Bool, finalized: Bool, squareVal: SquareVal = .EMPTY) {
        self.index = index
        self.checked = checked
        self.finalized = finalized
        self.squareVal = squareVal
    }
    
    func setFinalized() {
        finalized = true
    }
    
    func setChecked(playerMark: SquareVal){
       
        guard !finalized else { return }
        //guard squareVal == .EMPTY else { return }
        
        if checked {
            checked = false
            squareVal = SquareVal.EMPTY
        } else {
            checked = true
            squareVal = playerMark
        }
        
        print("Finalized: \(finalized)")
        print("Checked: \(checked)")
        print("SquareVal: \(squareVal)")
    }
}

enum SquareVal: String {
    case X = "X"
    case O = "O"
    case EMPTY = "E"
}
