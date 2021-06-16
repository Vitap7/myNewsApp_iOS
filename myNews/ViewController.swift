//
//  ViewController.swift
//  myNews
//
//  Created by 777 on 2021/5/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var news:News?
    var isStar:Bool = true
    
    @IBOutlet weak var NewsView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        print(news.title)
        print(news.path)
        print(news.passtime)
        */
        if let news = self.news
        {
            let url = URL(string: "\(news.path)")
            let urlReq = URLRequest.init(url: url!)
            NewsView.load(urlReq)
        }
    }
    
    
    @IBAction func starNews(_ sender: Any) {
        performSegue(withIdentifier: "Unwind", sender: self)
    }
}

