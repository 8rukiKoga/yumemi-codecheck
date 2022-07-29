//
//  TableViewDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 古賀遥貴 on 2022/07/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension MainViewController {
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
