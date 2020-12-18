//
//  NameInputViewController.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import UIKit

class GamingViewController: UIViewController {

    var squares = Squares()
    
    var xy = 0
    var yx = 0
    let vhheight = 50
    let squareSize = 50
    
    
    var selSquare: Square? = nil
    
    @IBOutlet weak var gridView: UIView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        squares.calcWinLines()
        
    }
    
    func createViews(){

        let squaresList = squares.getList()
        let cols = squares.columns
        
        for item in squaresList {
            
            let labelToAdd = createUIsquare(item: item)

            xy += squareSize + 5
            
            gridView.addSubview(labelToAdd)
            
            if (item.index % cols) == 0 {
                xy = 0
                yx += squareSize + 5
            }
            
        }

    }
    
    @objc func didTap(sender: UITapGestureRecognizer){
        if sender.state == .ended {
            
            guard let viewTag = sender.view?.tag else { return }
            print(viewTag)
            
            
            print("\(sender.view?.tag ?? 0)")

            
        }
    }
    
    func createUIsquare(item: Square) -> UILabel {
       
        let lbl = UILabel()
        
        lbl.frame = CGRect(x: xy, y: yx, width: vhheight, height: vhheight)
        lbl.tag = (item.index)
        lbl.text = "\(item.squareVal)"
        lbl.textAlignment = .center
        lbl.font.withSize(22)
        lbl.backgroundColor = .darkGray
        lbl.isUserInteractionEnabled = true
        
        let sTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
       // sTap.setValue(item, forKey: "item")
        
        lbl.addGestureRecognizer(sTap)
        
        print("Adding view..text: \(String(describing: lbl.text)) tag: \(lbl.tag)")
        
        return lbl
    }
    
   

}
