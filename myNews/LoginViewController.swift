//
//  LoginViewController.swift
//  myNews
//
//  Created by 777 on 2021/5/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let loginVC = UserLoginViewController()
        
        present(loginVC, animated: true, completion: nil)
        
        if loginVC.defaults.bool(forKey: loginVC.hasLogined)
        {
            loginVC.txtUser.text = loginVC.defaults.string(forKey: loginVC.stuNum)
        }

    }
}
