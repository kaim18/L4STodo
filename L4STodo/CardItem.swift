//
//  TodoItem.swift
//  L4STodo
//
//  Created by kai-munekuni on 2019/02/25.
//  Copyright © 2019年 kai-munekuni. All rights reserved.
//

import Foundation
import RealmSwift

class CardItem: Object {
    /// PrimaryKey用 ... 投稿一つ一つを区別するために用いる値

    @objc dynamic var frontContent: String = ""
    @objc dynamic var backContent: String = ""
    @objc dynamic var score = 0

    
    /// 日付を文字列で取得したいときに使う
//    var dateString: String {
//
//        get {
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .short
//            dateFormatter.timeStyle = .short
//            return dateFormatter.string(from: date)
//        }
//    }
//
//    /// PrimaryKey
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//
//    static func create() -> CardItem {
//        // インスタンス化
//        let item = CardItem()
//        // lastId()を使ってidを設定
//        item.id = lastId()
//        return item
//    }
//
//    /// 最後のIDを取ってくる
//    static func lastId() -> Int {
//        let realm = try! Realm()
//        // 投稿のうち最新のもののidを取ってくる
//        if let latestItem = realm.objects(CardItem.self).last {
//            return latestItem.id + 1
//        } else {
//            return 1
//        }
//    }
//
    /// すべての投稿を取ってくる
    static func loadAll() -> [CardItem] {
        let realm = try! Realm()
        // 投稿をidでソートして取得する
        let posts = realm.objects(CardItem.self)
        // 簡単のため配列に変換して返している（場合による）
        return posts.map { $0 }
    }
//
//    /// 自分自身を保存する
//    func save() {
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(self)
//        }
//    }
//
//    /// 更新の場合
//    func update(_ method: () -> Void) {
//        let realm = try! Realm()
//        try! realm.write {
//            method()
//        }
//    }
}

struct PostData {
    var text: String
    var name: String
    var imagePath: URL?
    var dateString: String
    var userId: String
}
