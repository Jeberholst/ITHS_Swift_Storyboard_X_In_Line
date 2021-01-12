//
//  GameModeViewController.swift
//  three-in-line
//
//  Created by Joakim Eberholst on 2020-12-21.
//

import UIKit

class GameModeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var gameModePicker: UIPickerView!

    private let userDefaultsSelectedColumn = "gameModeSelectedColumns"
    let gameModes = GameModes()
    var selectedGameModeColumns: Int = 3

    @IBAction func btnConfirm(_ sender: UIButton) {
        savedSelectedRow(columnCount: selectedGameModeColumns)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModePicker.dataSource = self
        gameModePicker.delegate = self

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameModes.getListCount()	
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(gameModes.getList()[row].name)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGameModeColumns = gameModes.getList()[row].columns
    }

    func savedSelectedRow(columnCount: Int) {
        let defaults = UserDefaults.standard
        defaults.setValue(columnCount, forKey: "gameModeSelectedColumns")
       // defaults.set(columnCount, forKey: userDefaultsSelectedColumn)
        defaults.synchronize()
    }

}
