//
//  LogInViewController.swift
//  ProjectPOC
//
//  Created by Sanad  on 1/29/18.
//  Copyright © 2018 Sanad . All rights reserved.
//

import UIKit
import FirebaseFirestore
class LogInViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var joinNowbtn: UIButton!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        joinNowbtn.layer.borderWidth = 1
        joinNowbtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        self.userNameTxt.delegate = self
        self.passwordTxt.delegate = self

    }
    @IBAction func joinNowBtnPressed(_ sender: Any) {
        // Add a new document with a generated ID
        let dataBase = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = dataBase.collection("users").addDocument(data: [
            "username": userNameTxt.text!,
            "password": passwordTxt.text!
        ]) { err in
            if let err = err {
                print("Error adding user: \(err)")
            } else {
                print("user added with ID: \(ref!.documentID)")
            }
        }

        
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.view.endEditing(true)
        activityIndicator.startAnimating()
        let dataBase = Firestore.firestore()
        dataBase.collection("users").whereField("username", isEqualTo: userNameTxt.text!).whereField("password", isEqualTo: passwordTxt.text!).getDocuments { (snapshot, error) in
            
            if error != nil {
                print(error)
            }else{
                print("Login successful!")
                
                
//                for document in (snapshot?.documents)! {
//                    if let password = document.data()["password"] as? String {
//                        print(password)
//
//                    }
//                }
                
            }
            self.activityIndicator.stopAnimating()
        }
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
