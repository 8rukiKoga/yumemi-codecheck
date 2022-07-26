//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet weak var SchBr: UISearchBar!
    
    var repo: [[String: Any]]=[]
    
    var task: URLSessionTask?
    var word: String!
    var url: String!
    var idx: Int!
    
    // 検索バーのテキストがユーザーによってタイプされたものか判断
    var isTypeStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 検索バーテキストの初期値
        SchBr.text = "GitHubのリポジトリを検索"
        SchBr.delegate = self
        
        // セルの高さを60に設定
        tableView.rowHeight = 60
    }
    
    // 遷移を検知
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! RepoDetailViewController
            dtl.vc1 = self
        }
        
    }
    
}
