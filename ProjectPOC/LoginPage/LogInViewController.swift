//
//  LogInViewController.swift
//  ProjectPOC
//
//  Created by Sanad  on 1/29/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import FirebaseFirestore
import FBSDKLoginKit
class LogInViewController: UIViewController,UITextFieldDelegate,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var fbLoginBtn: FBSDKLoginButton!
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.borderWidth = 1
        let constant = loginBtn.heightAnchor
        fbLoginBtn.heightAnchor.constraint(equalTo: constant, multiplier: 1).isActive = true
      
        loginBtn.layer.borderColor = UIColor.white.cgColor
        self.userNameTxt.delegate = self
        self.passwordTxt.delegate = self

    }
        // Add a new document with a generated ID
//        let dataBase = Firestore.firestore()
//        var ref: DocumentReference? = nil
//        ref = dataBase.collection("Friends").addDocument(data: [
//            "FriendName": userNameTxt.text!,
//            "FriendNumber": passwordTxt.text!
//        ]) { err in
//            if let err = err {
//                print("Error adding user: \(err)")
//            } else {
//                print("user added with ID: \(ref!.documentID)")
//            }
//        }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        self.view.endEditing(true)
        activityIndicator.startAnimating()
        let dataBase = Firestore.firestore()
        dataBase.collection("users").whereField("username", isEqualTo: userNameTxt.text!).whereField("password", isEqualTo: passwordTxt.text!).getDocuments { (snapshot, error) in
            
            if error != nil {
                print(error!)
            }else{
                print("Login successful!")
                
                for document in (snapshot?.documents)! {
                    
                    if let password = document.data()["password"] as? String  {
                        if let username = document.data()["username"] as? String {
                            print("Username= \(username),Password= \(password)")
                        }
                    }
                }
                
            }
            self.activityIndicator.stopAnimating()
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did logout of facebook!")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        activityIndicator.startAnimating()
        if error != nil {
            print(error)
            return
            
        }else{
            print("Successfully Logged in with facebook")
            let vc = LandinPageViewController(nibName: "LandinPageViewController", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        activityIndicator.stopAnimating()

    }
//touches anywherehide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        return (true)
    }
    
    
    
    

}
