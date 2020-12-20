import UIKit

var winningLines = [[Int]]()
var columns = 3
var rows = 3
var totSquares = (columns * rows)
    
var arrHorizontal = [[Int]]()
var diagonalArr = [[Int]]()

for ind in stride(from: 1, to: totSquares, by: columns){
    
    var hArr = [Int]()
    
    for addIndex in ind...(ind + columns)-1 {
        hArr.append(addIndex)
    }
    winningLines.append(hArr)
    arrHorizontal.append(hArr)
}
 
var arrVertical = [[Int]]()

for ind in (0...columns-1) {
    var vArr = [Int]()
    for sArr in arrHorizontal{

         vArr.append(sArr[ind])
    }
    winningLines.append(vArr)
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

winningLines.append(dArr)
winningLines.append(dArr2)

var winList = [[Int]]()

for winArr in winningLines {
    
    var arr = Array(repeating: 0, count: totSquares)
    
    for num in winArr {
        arr[num-1] = num
    }
    winList.append(arr)
    
}

//print(winningLines)
print(winList)
         
//            print("HorizontalArr: \(arrHorizontal)")
//            print("VerticalArr: \(arrVertical)")
//            print("DiagonalArr: \(diagonalArr)")
    
