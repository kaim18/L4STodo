//
//  ViewController.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/02/25.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    @IBOutlet var backTextField: UITextField!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addTodoItem() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        if textField.text!.isEmpty { return }
        let item = CardItem()
        item.frontContent = textField.text!
        item.backContent = backTextField.text!
        try! realm.write {
            realm.add(item)
        }
        let alert = UIAlertController(title: "追加完了", message: "追加完了", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.textField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

