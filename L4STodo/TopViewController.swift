//
//  TopViewController.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/03/17.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import Foundation
import UIKit
class TopViewController: UIViewController {
    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        label.transform = CGAffineTransform(rotationAngle: (.pi / 2)*3)
        let time = UserDefaults.standard.integer(forKey: "playTime")/60
        self.label.text = String(time) + "   minutes"
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
    
}
