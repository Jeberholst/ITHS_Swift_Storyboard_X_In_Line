//
//  GameMode.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-21.
//

import Foundation

class GameMode {
    var name: String
    var columns: Int
    
    init(name: String, columns: Int) {
        self.name = name
        self.columns = columns
    }
}
