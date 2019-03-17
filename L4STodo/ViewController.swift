//
//  ViewController.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/02/25.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var backTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var itemArray: [CardItem] = []
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        self.itemArray = CardItem.loadAll()
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 透明にしたナビゲーションを元に戻す処理
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController!.navigationBar.shadowImage = nil
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        cell.frontLabel.text = itemArray[indexPath.row].frontContent
        cell.backLabel.text = itemArray[indexPath.row].backContent
        return cell
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
            self.backTextField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }

}

