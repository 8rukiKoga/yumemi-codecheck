//
//  BmTableViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 古賀遥貴 on 2022/07/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension BookmarkViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    // セルが選択された時の動作を設定
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時にタップされたインデックスを代入して次のviewに渡す
        item = bookmarks[indexPath.row]
        performSegue(withIdentifier: "BmToDetail", sender: self)
    }

}
