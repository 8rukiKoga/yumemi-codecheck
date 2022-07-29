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
    
    // このDetailViewで扱うデータ
    var item: [String: Any]!
    
    var mvc: MainViewController?
    var bmc: BookmarkViewController?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // 遷移元からデータを受け取る
        // mvcから遷移したならmvc、bmcから遷移したならbmcのデータを代入する
        if mvc?.item != nil {
            self.item = mvc?.item
        } else {
            self.item = bmc?.item
        }
        // viewのテキストに代入
        LangLbl.text = "Written in \(item["language"] as? String ?? "")"
        StrsLbl.text = "\(item["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(item["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(item["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(item["open_issues_count"] as? Int ?? 0) open issues"
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
        
        TtlLbl.text = item["full_name"] as? String
        // avator_urlはownerの要素なので、そこから取り出す
        if let owner = item["owner"] as? [String: Any] {
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
        let item: [String: Any] = self.item
        bookmarks.append(item)
    }
    
}
