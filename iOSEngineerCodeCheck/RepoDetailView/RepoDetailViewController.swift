//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    
    @IBOutlet weak var TtlLbl: UILabel!

    @IBOutlet weak var LangLbl: UILabel!
    
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    // ブックマークに追加するボタン
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    var mvc: MainViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // インデックスのデータを受け取る
        let repo = mvc.repo[mvc.idx]
        // viewのテキストに代入
        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
        // ボタンの見た目を設定
        modifyBtnAppearance()
    }
    
    // ボタンの見た目を設定
    func modifyBtnAppearance() {
        bookmarkBtn.layer.cornerRadius = 20
        bookmarkBtn.layer.borderWidth = 1
        bookmarkBtn.layer.borderColor = UIColor.link.cgColor
    }
    
    // 画像を入手
    func getImage(){
        
        let repo = mvc.repo[mvc.idx]
        
        TtlLbl.text = repo["full_name"] as? String
        // avator_urlはownerの要素なので、そこから取り出す
        if let owner = repo["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        // viewの画像に代入
                        self.ImgView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
    @IBAction func tapBookmarkBtn(_ sender: Any) {
        let item: [String: Any] = mvc.repo[mvc.idx]
        bookmarks.append(item)
    }
    
}