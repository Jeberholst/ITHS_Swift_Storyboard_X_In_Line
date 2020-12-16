//
//  NameInputViewController.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-16.
//

import UIKit

class GamingViewController: UIViewController {

    var squares = Squares()
    
   // @IBOutlet weak var verticalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        
    }
    
    func createViews(){

        let squaresList = squares.getList()
        
        for item in squaresList {
            let lbl = UILabel()
            lbl.tag = (item.index)
            lbl.text = "Square \(item.index)"
            
            print("Adding view.. text: \(String(describing: lbl.text)) tag: \(lbl.tag)")
        
            //ADDVIEW
            	
        }

    }
    
}
