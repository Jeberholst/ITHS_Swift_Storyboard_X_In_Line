//
//  Squares.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import Foundation

class Squares {
    
    private var list: [Square]
    
    //TODO: ADD AS INPUT VARIABLE?
    var columns = 3
    var rows = 3
    var totSquares: Int
    
    var winningLines = [[Int]]()
    
    init() {
        list = [Square]()
        totSquares = (columns * rows)
        
        addInitialSquares(amount: totSquares)
    }
    
    private func addInitialSquares(amount: Int){
        let squaresToAdd = (1...amount)
        
        squaresToAdd.forEach { i in
            let sq = Square(index: i, checked: false, finalized: false)
            //print(sq)
            addASquare(square: sq)
        }
    }
    
    func addASquare(square: Square){
        list.append(square)
    }
    
    func getList() -> [Square] {
        return list
    }
    
    func getSquare(index: Int) -> Square {
        return list[index-1]
    }
    
    func isCheckBoardFull() -> Bool {
        var count = 0
        for item in list {
            if(item.finalized){
                count += 1
            }
        }
        if count == list.count {
            return true
        }
        return false
    }
    
    func resetBoard(){
        list.forEach{ item in
            item.checked = false
            item.finalized = false
            item.squareVal = .EMPTY
        }
    }
    
    func calculateSquareSize(containerViewWidth: Int) -> Int {
        let size = (containerViewWidth/columns) - 5
        return size
    }
    
    func checkIfWin(currPlayer: Player?) -> Bool {
        
        if currPlayer != nil {
            for item in winningLines {
                var counter = 0
                for i in (0...item.count-1) {
                    if currPlayer!.selectedSquares[i] == item[i] {
                        counter += 1
                    }
                }
                if(counter == columns){
                    print("WIN")
                    return true
                }

            }
        }
        
        return false
        
    }
    
    func calcWinLines(){
        
            var winLines = [[Int]]()
            var arrHorizontal = [[Int]]()
            //var diagonalArr = [[Int]]()
            
            for ind in stride(from: 1, to: totSquares, by: columns){
                
                var hArr = [Int]()
                
                for addIndex in ind...(ind + columns)-1 {
                    hArr.append(addIndex)
                }
                winLines.append(hArr)
                arrHorizontal.append(hArr)
            }
             
            var arrVertical = [[Int]]()
            
            for ind in (0...columns-1) {
                var vArr = [Int]()
                for sArr in arrHorizontal{
                     vArr.append(sArr[ind])
                }
                winLines.append(vArr)
                arrVertical.append(vArr)
            }
           
            var dArr = [Int]()
            for i in 1...columns {
                dArr.append(arrHorizontal[i-1][i-1])
            }
        
            //diagonalArr.append(dArr)
            
            let rev = arrVertical.reversed() as Array
            //print(rev)
            
            var dArr2 = [Int]()
            for i in 1...columns {
                dArr2.append(rev[i-1][i-1])
            }
            //diagonalArr.append(dArr2)
        
            winLines.append(dArr)
            winLines.append(dArr2)
        
            for winArr in winLines {
                
                var arr = Array(repeating: 0, count: totSquares)
                
                for num in winArr {
                    arr[num-1] = num
                }
                winningLines.append(arr)
                
            }
        
            print("Possible matches: \(winningLines)")
            
        }
    
}
