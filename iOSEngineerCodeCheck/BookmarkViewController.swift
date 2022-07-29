//
//  BookmarkViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 古賀遥貴 on 2022/07/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // 表示するの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Bookmark", for: indexPath)
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Detail"
        return cell
    }
    
}
