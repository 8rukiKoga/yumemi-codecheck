//
//  SearchBarDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 古賀遥貴 on 2022/07/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension MainViewController: UISearchBarDelegate {
    
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
