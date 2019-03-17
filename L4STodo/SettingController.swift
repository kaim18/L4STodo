//
//  SettingController.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/03/16.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import Foundation
import UIKit
class SettingController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.numberOfLines = 0
        setTitle()
    }
    @IBAction func change (){
        if let title = textField.text {
            if title.isEmpty {
                return
            }
            UserDefaults.standard.set(Int(title), forKey: "goal")
            textField.text = ""
            setTitle()
        }
    }
    func setTitle(){
        let text = "You hove studied for " + String(UserDefaults.standard.integer(forKey: "sum")) + "minuetes." + "Now your goal is to study " + String(UserDefaults.standard.integer(forKey: "goal")) + "minutes a day."
        titleLabel.text = text
    }
}
