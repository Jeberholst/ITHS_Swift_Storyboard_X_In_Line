//
//  NameInputViewController.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import UIKit

class GamingViewController: UIViewController {

    var squares = Squares()
    var players = Players()
    var currentPlayer: Player? = nil

    var xy = 0
    var yx = 0
    let vhheight = 50
    let squareSize = 50
    var selSquare: Square? = nil
    let squareList = Squares().getList()
    
    var turn = 0
    
    @IBOutlet weak var gridView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPlayers()
        
        changeTurn()
        
        createViews()
        squares.calcWinLines()
        
    }
    
    func addPlayers(){
        
        let player1 = Player(name: "Jocke", points: [Int](), rounds: [Int](), marker: SquareVal.X)
        let player2 = Player(name: "Anon", points: [Int](), rounds: [Int](), marker: SquareVal.O)
        
        players.addPlayer(player: player1)
        players.addPlayer(player: player2)
        
        players.setResetAllSelections(count: squares.totSquares)
        
    }
    
    func createViews(){

        let cols = squares.columns
        
        for item in squareList {
            
            let labelToAdd = createUIsquare(item: item)

            xy += squareSize + 5
            
            gridView.addSubview(labelToAdd)
            
            if (item.index % cols) == 0 {
                xy = 0
                yx += squareSize + 5
            }
            
        }

    }

    
    func finalizeSquare(){
        selSquare?.setFinalized()
    }
    
    func resetLabelSquares(){
        for item in squares.getList() {
            let findLbl = self.view.viewWithTag(item.index) as? UILabel
            findLbl?.text = item.squareVal.rawValue
        }
    }
    
    func createUIsquare(item: Square) -> UILabel {
       
        let lbl = UILabel()
        
        lbl.frame = CGRect(x: xy, y: yx, width: vhheight, height: vhheight)
        lbl.tag = (item.index)
        lbl.text = "\(item.squareVal.rawValue)"
        lbl.textAlignment = .center
        lbl.font.withSize(22)
        lbl.isUserInteractionEnabled = true
        lbl.layer.borderColor = UIColor.gray.cgColor
        lbl.layer.borderWidth = 1
        lbl.layer.cornerRadius = 5
        
        let sTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        
        lbl.addGestureRecognizer(sTap)
        
        //print("Adding view..text: \(String(describing: lbl.text)) tag: \(lbl.tag)")
        
        return lbl
    }
    
    
    @objc func didTap(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            
            guard let viewTag = sender.view?.tag else { return }
            print(viewTag)
            
            selSquare = squares.getSquare(index: viewTag)
            
            guard let selSquare = selSquare else { return }
            guard let marker = currentPlayer?.marker else { return }
            
            selSquare.setChecked(playerMark: marker)
            
            let targetLbl = self.view.viewWithTag(viewTag) as? UILabel
            
            targetLbl?.text = selSquare.squareVal.rawValue
            
            //TODO MOVE TO BTN CLICK?
            finalizeSquare()
             
            print("Square Finalized: \(selSquare.finalized)")
            currentPlayer?.selectedSquares[viewTag-1] = viewTag
            print("Selected Squares: \(currentPlayer?.selectedSquares)")
            //CHECK AFTER EACH PLACEMENT
            checkIfWin()
            print("CheckBoard Full: \(squares.isCheckBoardFull())")
            changeTurn()
            
            
            if(squares.isCheckBoardFull()){
                squares.resetBoard()
                players.setResetAllSelections(count: squares.totSquares)
                resetLabelSquares()
            }

        }
    }
    
    func changeTurn(){
        if(turn == 0){
            turn = 1
        }else{
            turn = 0
        }
        setCurrentPlayer()
    }
    
    func setCurrentPlayer(){
        currentPlayer = players.getList()[turn]
    }
    
    func checkIfWin(){
        let winList = squares.winningLines
        
        if currentPlayer != nil {
            print(currentPlayer!)
            
            for item in winList {
                var counter = 0
                for i in (0...item.count-1) {
                    //print("i: \(i)")
                    if currentPlayer!.selectedSquares[i] == item[i] {
                        counter += 1
                    }
                }
                print("Item: \(item)")
                print("cnt \(counter)")
            }
        }
    }
    
}
