//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UISearchBarDelegate {

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

// 検索バー
extension ListViewController {
    // 検索バーが最初にタップされたときの動作
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        // 検索バーの初期値が変更された(これ以降のテキストはユーザー次第)
        isTypeStarted = true
        // 編集可と返す
        return true
    }
    
    // 検索バーの中身が変わったときの動作
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 検索の非同期処理をキャンセル
        task?.cancel()
    }
    
    // 検索バーが押された時の動作
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // word変数に入力された値を代入
        word = searchBar.text!
        
        // もし検索バーに文字が入っていたら、その文字で検索
        if word.count != 0 {
            // 日本語を日本語のまま検索するとnilが返ってくるので、キーワードをエンコードする
            let encodedStr = word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            url = "https://api.github.com/search/repositories?q=\(encodedStr!)"
            
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                // 検索結果をobjに、その中からタイトル・言語などがある"items"を取り出す
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                        self.repo = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            // これ呼ばなきゃリストが更新されません
            task?.resume()
        }
        
    }
}

// リスト
extension ListViewController {
    // テーブルに表示するセル数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 検索ワードが初期値でなく、かつ検索ワードで見つからなかった場合
        if isTypeStarted && repo.isEmpty {
            return 1
        } else {
            return repo.count
        }
    }
    
    // テーブルに表示する情報を設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath)
        // 検索ワードが初期値でなく、かつ検索ワードで見つからなかった場合
        if isTypeStarted && repo.isEmpty {
            cell.textLabel?.text = "Not Found"
            cell.detailTextLabel?.text = ""
        } else {
            let rp = repo[indexPath.row]
            // レポジトリ名・言語を表示
            cell.textLabel?.text = rp["full_name"] as? String ?? ""
            cell.detailTextLabel?.text = rp["language"] as? String ?? ""
            cell.tag = indexPath.row
        }
        return cell
        
    }
    
    // セルが選択された時の動作を設定
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時にタップされたインデックスを代入して次のviewに渡す
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
}
