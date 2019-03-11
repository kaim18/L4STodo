//
//  FlashCardViewController.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/03/11.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import Foundation
import UIKit

class FlashCardViewController: UIViewController {
    @IBOutlet var cardContent: UILabel!
    var cardItems: [CardItem]!
    var cardIndex: Int = 0
    var timer: Timer!
    var distance: Double = (UIApplication.shared.delegate as! AppDelegate).distance {
        didSet {
            (UIApplication.shared.delegate as! AppDelegate).distance = distance
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardItems = CardItem.loadAll()
        cardContent.text = cardItems[cardIndex].frontContent
        print(cardItems)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
            self.distance += 1
        })
    }
    
    @IBAction func load() {
        UIView.transition(with: cardContent, duration: 0.4, options: [.transitionFlipFromRight], animations: {
            if self.cardContent.text == self.cardItems[self.cardIndex].frontContent{
                self.cardContent.text = self.cardItems[self.cardIndex].backContent
            }else{
                self.cardContent.text = self.cardItems[self.cardIndex].frontContent
            }
        }, completion: nil)
    }
    @IBAction func right(){
        moveIndex(num:self.cardIndex + 1)
    }
    @IBAction func left(){
        moveIndex(num:self.cardIndex - 1)
    }
    @IBAction func getPlayingDuration() {
    }
    
    func moveIndex(num :Int){
        let length = cardItems.count
        var options: UIView.AnimationOptions!
        if num < 0 {
            self.cardIndex = length - 1
            options = [.transitionCurlUp]
        } else if num > length - 1{
            self.cardIndex = 0
            options = [.transitionCurlDown]
        } else {
            if num < cardIndex {
                options = [.transitionCurlDown]
            } else {
                options = [.transitionCurlUp]
            }
            self.cardIndex = num
        }
        
        UIView.transition(with: cardContent, duration: 0.4, options: options, animations: {
            self.cardContent.text = self.cardItems[self.cardIndex].frontContent
        }) { _ in
        }
    }
}
