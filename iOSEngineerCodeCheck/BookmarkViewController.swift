//
//  BookmarkViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 古賀遥貴 on 2022/07/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

// ブックマークリストのグローバル変数
var bookmarks: [[String: Any]] = []

class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // テーブルビュー
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(bookmarks)
        
        // セルの高さを60に設定
        tableView.rowHeight = 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // 表示するの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ブックマークリストが空の場合
        if bookmarks.isEmpty {
            return 1
        }
        // ブックマークリストに要素がある場合
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Bookmark", for: indexPath)
        
        // ブックマークリストが空の場合
        if bookmarks.isEmpty {
            cell.textLabel?.text = "ブックマークが空です！"
            cell.detailTextLabel?.text = ""
            return cell
        }
        // ブックマークリストに要素がある場合
        let bookmark = bookmarks[indexPath.row]
        // レポジトリ名・言語を表示
        cell.textLabel?.text = bookmark["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = bookmark["language"] as? String ?? ""
        cell.tag = indexPath.row
        
        return cell
    }
    
}
