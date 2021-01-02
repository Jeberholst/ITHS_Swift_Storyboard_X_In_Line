//
//  NameInputViewController.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import UIKit

class GamingViewController: UIViewController {

    private let userDefaultsSelectedColumn = "gameModeSelectedColumns"
    
    var squares = Squares()
    var players = Players()
    var currentPlayer: Player? = nil
    var round = 0
    var isBoardFull: Bool = false
    var isPlayerWin: Bool = false
    
    @IBOutlet weak var squaresContainer: UIView!
    
    @IBOutlet weak var lblRound: UILabel!
    
    @IBOutlet var playerNameLabels: [UILabel]!
    @IBOutlet var playerPointsLabels: [UILabel]!
    @IBOutlet var playerVerticalStacks: [UIStackView]!
    
    @IBOutlet weak var btnNextRound: UIButton!
    
    @IBAction func editPlayers(_ sender: UIBarButtonItem) {
        openNameInputDialog()
    }
    
    @IBAction func btnNextRound(_ sender: UIButton) {
        onNextRound()
    }
    
    var xy = 0
    var yx = 0
    var squareSize = 0
    var selSquare: Square? = nil
    var squareList: [Square] = []
    
    var turn = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squares.setColumns(columns: getSelectedGameMode())
        squareList = squares.getList()
        increaseRound()
        hideShowBtnNextRound(hidden: true)
        initialPlayerSetup()
        squareSize = squares.calculateSquareSize(containerViewWidth: Int(squaresContainer.bounds.width) - (squares.columns * 5))
        changeTurn()
        createViews()
        squares.calcWinLines()
    }
    
    func getSelectedGameMode() -> Int {
        let selectedGameModeColumns = UserDefaults.standard.integer(forKey: userDefaultsSelectedColumn)
        return selectedGameModeColumns
    }
    
    func initialPlayerSetup(){
        players.setResetAllSelections(count: squares.totSquares)
        UIupdatePlayerPoints()
        UIupdatePlayerNames()
    }
    
    func UIupdatePlayerPoints(){
        playerPointsLabels[0].text = String(players.getList()[0].pointsTotal())
        playerPointsLabels[1].text = String(players.getList()[1].pointsTotal())
    }
    
    func UIupdatePlayerNames(){
        playerNameLabels[0].text = players.getList()[0].name
        playerNameLabels[1].text = players.getList()[1].name
    }
    
    func createViews(){

        let cols = squares.columns
        
        for item in squareList {
            let labelToAdd = createUIsquare(item: item)
            xy += (squareSize + 5)
            squaresContainer.addSubview(labelToAdd)
            viewFadeIn(view: labelToAdd)
            
            if (item.index % cols) == 0 {
                xy = 0
                yx += (squareSize + 5)
            }
        }
    }
    
    func resetLabelSquares(){
        for item in squares.getList() {
            let findLbl = self.view.viewWithTag(item.index) as? UILabel
            if let findLbl = findLbl {
                viewFadeOutIn(lbl: findLbl, setText: item.squareVal.rawValue)
            }
        }
    }
    
    func createUIsquare(item: Square) -> UILabel {
       
        let lbl = UILabel()
                
        lbl.frame = CGRect(x: xy, y: yx, width: squareSize, height: squareSize)
        lbl.tag = (item.index)
        lbl.text = "\(item.squareVal.rawValue)"
        lbl.textAlignment = .center
        lbl.font.withSize(22)
        lbl.isUserInteractionEnabled = true
        lbl.layer.borderColor = UIColor.gray.cgColor
        lbl.layer.borderWidth = 1
        lbl.layer.cornerRadius = 5
        lbl.alpha = 0.0
        
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
            
            selSquare.setFinalized()
            targetLbl?.isUserInteractionEnabled = false
             
            currentPlayer?.selectedSquares[viewTag-1] = viewTag
            	
            isBoardFull = squares.isCheckBoardFull()
            isPlayerWin = squares.checkIfWin(currPlayer: currentPlayer)
            
            if (isBoardFull){
                if(!isPlayerWin){
                    onDraw()
                } else {
                    onWin()
                }
            } else {
                if(isPlayerWin){
                    onWin()
                }
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
        setBackgroundColorActivePlayer()
    }
    
    func setCurrentPlayer(){
        currentPlayer = players.getList()[turn] 
    }
    
    func setBackgroundColorActivePlayer(){
        
        let turnStackNot = playerVerticalStacks[calcNonTurn()]
        let turnStack = playerVerticalStacks[turn]

        turnStackNot.subviews.forEach{ v in
            let view = v as? UILabel
            view?.textColor = UIColor.systemGray4
        }
        
        turnStack.subviews.forEach{ v in
            let view = v as? UILabel
            view?.textColor = UIColor.black
        }
    }
    
    func calcNonTurn() -> Int {
        switch turn {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func onWin(){
        currentPlayer?.addPointAndCurrRound(point: 1, currRound: round)
        UIupdatePlayerPoints()
        disableInput()
        displayWin()
    }

    func onDraw(){
        currentPlayer?.addPointAndCurrRound(point: 0, currRound: round)
        disableInput()
        displayDraw()
    }
    
    func displayWin(){
        if let playerName = currentPlayer?.name {
            viewFadeOutIn(lbl: lblRound, setText: "\(playerName) has won")
        }
    }

    func displayDraw(){
        viewFadeOutIn(lbl: lblRound, setText: "Ended in a draw")
    }
    
    func disableInput(){
        disableEnableSquaresLabelClick(enable: false)
        hideShowBtnNextRound(hidden: false)
    }
    
    func enableInput(){
        disableEnableSquaresLabelClick(enable: true)
        hideShowBtnNextRound(hidden: true)
    }
    
    func onNextRound(){
        squares.resetBoard()
        resetLabelSquares()
        players.setResetAllSelections(count: squares.totSquares)
        enableInput()
        increaseRound()
    }
    
    func increaseRound(){
        round += 1
        viewFadeOutIn(lbl: lblRound, setText: "Round \(round)")
    }
    
    func disableEnableSquaresLabelClick(enable: Bool){
        for child in squaresContainer.subviews {
            if(child is UILabel){
                child.isUserInteractionEnabled = enable
            }
        }
    }
    
    func viewFadeIn(view: UIView){
        UIView.animate(withDuration: 1.0, animations: {
            view.alpha = 1.0
        })
    }
    
    func viewFadeOutIn(lbl: UILabel, setText: String){
        UIView.animate(withDuration: 1.0, animations: {
            lbl.alpha = 0.0
        }, completion: {_ in
            
            lbl.text = setText
            
            UIView.animate(withDuration: 1.0, animations: {
                lbl.alpha = 1.0
            }, completion: { _ in
                
            })
        })
    }
    
    func hideShowBtnNextRound(hidden: Bool) {
        btnNextRound.isHidden = hidden
        viewFadeIn(view: btnNextRound)
    }
    
    func openNameInputDialog() {
        let alertUI = UIAlertController(title: "Edit names",
                                        message: "Use fields below to input names",
                                        preferredStyle: .alert)
        
        alertUI.addTextField{ textField in
            //textField.placeholder = "Name of Player 1"
            textField.text = self.players.getList()[0].name
            textField.autocapitalizationType = .words
        }
        alertUI.addTextField{ textField in
            //textField.placeholder = "Name of Player 2"
            textField.text = self.players.getList()[1].name
            textField.autocapitalizationType = .words
        }
        
        let actionSave = UIAlertAction(title: "Save", style: .default) { action in
            let tf1 = alertUI.textFields![0] as UITextField
            let tf2 = alertUI.textFields![1] as UITextField
            
            guard let name1 = tf1.text else { return }
            guard let name2 = tf2.text else { return }
            
            self.players.getList()[0].name = name1
            self.players.getList()[1].name = name2

            self.UIupdatePlayerNames()
        }
        
        alertUI.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertUI.addAction(actionSave)
        
        present(alertUI, animated: true)
    }
    
}
