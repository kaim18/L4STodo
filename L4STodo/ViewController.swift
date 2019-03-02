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
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addTodoItem() {
        let item = CardItem()
        item.frontContent = "hoge"
        item.backContent = "fuga"
        try! realm.write {
            realm.add(item)
        }
    }

}

