//
//  NameInputViewController.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import UIKit

class GamingViewController: UIViewController {

    var squares = Squares()
    let players = Players()

    var xy = 0
    var yx = 0
    let vhheight = 50
    let squareSize = 50
    var selSquare: Square? = nil
    let squareList = Squares().getList()
    
    @IBOutlet weak var gridView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPlayers()
        
        createViews()
        squares.calcWinLines()
        
    }
    
    func addPlayers(){
        
        let player1 = Player(name: "Jocke", points: [Int](), rounds: [Int](), marker: "X")
        let player2 = Player(name: "Anon", points: [Int](), rounds: [Int](), marker: "O")
        
        players.addPlayer(player: player1)
        players.addPlayer(player: player2)
        
        for player in players.getList() {
            print(player)
        }
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
        
        print("Adding view..text: \(String(describing: lbl.text)) tag: \(lbl.tag)")
        
        return lbl
    }
    
    
    @objc func didTap(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            
            guard let viewTag = sender.view?.tag else { return }
            print(viewTag)
            
            selSquare = squares.getSquare(index: viewTag)
            
            guard let selSquare = selSquare else { return }
            
            selSquare.setChecked()
            
            let targetLbl = self.view.viewWithTag(viewTag) as? UILabel
            
            targetLbl?.text = selSquare.squareVal.rawValue
            
            //TODO MOVE TO BTN CLICK
                finalizeSquare()
                //selSquare.setFinalized()
                print("Square Finalized: \(selSquare.finalized)")
            //CHECK AFTER EACH PLACEMENT
                print("CheckBoard Full: \(squares.isCheckBoardFull())")
            squares.calcWinningSquares()
            
            if(squares.isCheckBoardFull()){
                squares.resetBoard()
                resetLabelSquares()
            }

        }
    }
    
}
