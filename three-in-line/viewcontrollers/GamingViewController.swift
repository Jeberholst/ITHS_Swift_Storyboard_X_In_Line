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
    var round = 0
    var isBoardFull: Bool = false
    var isPlayerWin: Bool = false
    
    @IBOutlet weak var squaresContainer: UIView!
    
    @IBOutlet weak var lblPlayer1Name: UILabel!
    @IBOutlet weak var lblPlayer2Name: UILabel!
    @IBOutlet weak var lblPlayer1Points: UILabel!
    @IBOutlet weak var lblPlayer2Points: UILabel!
    @IBOutlet weak var lblRound: UILabel!

    @IBOutlet weak var btnNextRound: UIButton!
    
    @IBAction func btnNextRound(_ sender: UIButton) {
        onNextRound()
    }
    
    var xy = 0
    var yx = 0
    let vhheight = 50
    let squareSize = 50
    var selSquare: Square? = nil
    let squareList = Squares().getList()
    
    var turn = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()	
        increaseRound()
        hideShowBtnNextRound(hidden: true)
        
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
        
        lblPlayer1Name.text = String(player1.name)
        lblPlayer1Points.text = "1"
        lblPlayer2Name.text = String(player2.name)
        lblPlayer2Points.text = "0"
       
    }
    
    func updatePlayerPointsUI(){
        
        
    }
    
    func createViews(){

        let cols = squares.columns
        
        for item in squareList {
            let labelToAdd = createUIsquare(item: item)
            xy += squareSize + 5
            squaresContainer.addSubview(labelToAdd)
            
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
        
        return lbl
    }
    
    
    @objc func didTap(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            
            guard let viewTag = sender.view?.tag else { return }
            
            selSquare = squares.getSquare(index: viewTag)
            
            guard let selSquare = selSquare else { return }
            guard let marker = currentPlayer?.marker else { return }
            
            selSquare.setChecked(playerMark: marker)
            
            let targetLbl = self.view.viewWithTag(viewTag) as? UILabel
            
            targetLbl?.text = selSquare.squareVal.rawValue
            
            finalizeSquare()
             
            currentPlayer?.selectedSquares[viewTag-1] = viewTag
            	
            isBoardFull = squares.isCheckBoardFull()
            isPlayerWin = squares.checkIfWin(currPlayer: currentPlayer)
            
            if(isPlayerWin){
                onWin()
            }
            
            if(isBoardFull == true && isPlayerWin != false){
                onDraw()
            }
            
            changeTurn()
            
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
    
    func onWin(){
        currentPlayer?.addPointAndCurrRound(point: 1, currRound: round)
        //ADD OTHER PLAYER IN VAR?
        disableEnableSquaresLabelClick(enable: false)
        hideShowBtnNextRound(hidden: false)
    }
    
    func onDraw(){
        currentPlayer?.addPointAndCurrRound(point: 0, currRound: round)
        //ADD OTHER PLAYER IN VAR?
        disableEnableSquaresLabelClick(enable: false)
        hideShowBtnNextRound(hidden: false)
    }
    
    func onNextRound(){
        squares.resetBoard()
        resetLabelSquares()
        players.setResetAllSelections(count: squares.totSquares)
        disableEnableSquaresLabelClick(enable: true)
        changeTurn()
        increaseRound()
        hideShowBtnNextRound(hidden: true)
    }
    
    func increaseRound(){
        round += 1
        lblRound.text = "Round \(round)"
    }
    
    func disableEnableSquaresLabelClick(enable: Bool){
        for child in squaresContainer.subviews {
            if(child is UILabel){
                child.isUserInteractionEnabled = enable
            }
        }
    }
    
    func hideShowBtnNextRound(hidden: Bool){
        btnNextRound.isHidden = hidden
    }
    
}
