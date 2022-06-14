//
//  SignInViewController.swift
//  TakeItEasy
//
//  Created by Zack on 6/8/22.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {


    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var remSwitch: UISwitch!
    
    let userDef = UserDefaults.standard
    let switchStatus = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(switchStatus.bool(forKey: "switch")){
            remSwitch.setOn(true, animated: true)
            let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : userDef.value(forKey: "UN") as! String, kSecReturnAttributes as String : true, kSecReturnData as String : true]
            var res : CFTypeRef?
            if(SecItemCopyMatching(req as CFDictionary, &res) == noErr){
                let data = res as? [String : Any]
                let uID = data![kSecAttrAccount as String] as? String
                let passData = (data![kSecValueData as String] as? Data)!
                let pass = String(data : passData, encoding: .utf8)
                enterEmailTextField.text = uID
                enterPasswordTextField.text = pass

            }else{
                print("error calling remember me data")
            }

        }else{
            remSwitch.setOn(false, animated: true)
        }


        // Do any additional setup after loading the view.
    }
    
    @IBAction func rememberMe(_ sender: Any) {
        if(remSwitch.isOn ==  true){
            switchStatus.set(true, forKey: "switch")
                
                userDef.set(enterEmailTextField.text, forKey: "UN")
                  let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : enterEmailTextField.text!, kSecValueData as String : enterPasswordTextField.text!.data(using: .utf8)]
                  if(SecItemAdd(attribute as CFDictionary, nil ) == noErr){
                      print("remember me is saved")
                  }else{
                      print("remember me not saved")
                  }
              }else{
                  switchStatus.set(false, forKey: "switch")
                  let req : [String: Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : enterEmailTextField.text!]
                  if(SecItemDelete(req as CFDictionary) == noErr){
                      print("delete remember")
                  }else{
                      print("error with deleting remember")
                  }
              }
    }
    
    @IBAction func buttonSignIn(_ sender: Any) {
        //1. validate username and password inputs
        let emailTextField = enterEmailTextField.text!
        let passwordTextField = enterPasswordTextField.text!
        
        func checkInput(text : String) -> Bool {
            var isValid = false
            if !text.isEmpty && text != "" && text != nil {
                isValid = true
            }
            return isValid
        }
        
        if checkInput(text: emailTextField) && checkInput(text: passwordTextField) {
            //check if user is registered
            if !DBHelperUser.dbHelperUser.isUserRegistered(username: emailTextField) {
                errorMessage.text = "Please sign in first"
            }
            //check if password is correct
            //let correctPassword = DBHelperUser.dbHelperUser.getOne(username: usernameTextField!).password
            let user = DBHelperUser.dbHelperUser.getOne(username: emailTextField)
            let correctPassword = user.password
            if passwordTextField == correctPassword {
                //present the tab bar controller in full screen
                let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
                let loginNextScreen = storyboard.instantiateViewController(withIdentifier: "viewController")
                //show the tab controller as an instantiated vc
                loginNextScreen.modalPresentationStyle = .fullScreen
                self.present(loginNextScreen, animated: true, completion: nil)
                //save password to keychain if remember me is on
                //savePassword()
            } else {
                errorMessage.text = "Please check username/password."
            }
        } else {
            errorMessage.text = "Please input username/password."
        }
        //2. save password to keychain if remember me is on
//        func savePassword() {
//            if rememberMe.isOn {
//                //save password to keychain
//
//                let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : enterEmailTextField.text!]
//
//                let attributeUsername : [String : Any] = [kSecAttrAccount as String : enterEmailTextField!]
//
//                let attributePassword : [String : Any] = [kSecValueData as String : enterPasswordTextField.text!.data(using: .utf8)!]
//
//                if SecItemUpdate(request as CFDictionary, attributePassword as CFDictionary) == noErr && SecItemUpdate(request as CFDictionary, attributeUsername as CFDictionary) == noErr {
//                    print("User data saved in keychain.")
//                } else {
//                    print("Error.")
//                }
//                //save this user to userDefaults
//                let userDefaults = UserDefaults.standard
//                userDefaults.set(enterEmailTextField.text!, forKey: "UserRemembered")
//            }
//            if rememberMe.isOn == false {
//                let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : enterEmailTextField.text!]
//
//                if SecItemDelete(request as CFDictionary) == noErr {
//                    print("User data deleted.")
//                }
//                else {
//                    print("Error.")
//                }
//            }
//
//        }
    }
        
    }

    

