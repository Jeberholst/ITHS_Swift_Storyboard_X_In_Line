//
//  Square.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

struct Square {
    
    var index: Int
    var checked: Bool
    var finalized: Bool
    var squareVal: SquareVal = .EMPTY
    
    func isValid() -> Bool {
        print(finalized)
        return finalized
    }
    
    mutating func setChecked(){
       
        guard !finalized else { return }
        guard squareVal == .EMPTY else { return }
        
        print("Finalized: \(finalized)")
        print("Checked: \(checked)")
        print("SquareVal: \(squareVal)")
        
        if checked {
            checked = false
        } else {
            checked = true
        }
    }
}

enum SquareVal: String {
    case X = "X"
    case O = "O"
    case EMPTY = ""
}
