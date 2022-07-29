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

class BookmarkViewController: UIViewController {
    
    // テーブルビュー
    @IBOutlet weak var tableView: UITableView!
    
    // DetailViewに渡すアイテム
    var item: [String: Any] = [:]
    
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
    
    // 遷移を検知
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "BmToDetail"{
            if let dtl = segue.destination as? RepoDetailViewController {
                dtl.bmc = self
            }
        }
        
    }
}
