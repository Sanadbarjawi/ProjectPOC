//
//  LandinPageViewController.swift
//  ProjectPOC
//
//  Created by Sanad  on 1/30/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LandinPageViewController: UIViewController,FBSDKLoginButtonDelegate  {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Did llo")

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of facebook!")
        navigationController?.popViewController(animated: true)

    }
  
}
