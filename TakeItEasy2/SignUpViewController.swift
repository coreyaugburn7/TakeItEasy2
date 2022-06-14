//
//  SignUpViewController.swift
//  TakeItEasy
//
//  Created by Zack on 6/8/22.
//

import Foundation
import UIKit
import CoreData

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var ReEnterPasswordTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var remSwitch: UISwitch!
    @IBOutlet weak var SignIn: UIButton!
    
    var pin = 1234
    var errorMsg = ""
    let userDef = UserDefaults.standard
    let switchStatus = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func test() {
       let b = regexValidation(value: enterEmailTextField.text!, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        if !b {
            self.errorMessage.text = "HELP"
        }
    }

    @IBAction func rememberMe(_ sender: Any) {
        if(remSwitch.isOn ==  true){
            switchStatus.set(true, forKey: "switch")
                
                userDef.set(enterEmailTextField.text as? String, forKey: "UN")
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
    
    
    @IBAction func getOPT(_ sender: Any) {
        let dialogMessage = UIAlertController(title: "Alert", message: "Your code is \(pin)", preferredStyle: .alert)
                
                // Create Confirm button with action handler
                let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
                    print("Confirm button tapped")
                    //self.SignIn.isHidden = false
                    self.displaySecondPush()
                })
                
                // Create Cancel button with action handlder
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                    print("Cancel button tapped")
                }
                
                //Add OK and Cancel button to dialog message
                dialogMessage.addAction(confirm)
                dialogMessage.addAction(cancel)
                
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
            }
    
    func displaySecondPush() {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Please Enter your code", preferredStyle: .alert)
        
        // Add a text field
        dialogMessage.addTextField(configurationHandler: { textField in
            textField.placeholder = "Type in your PIN"
        })
                
                // Create Confirm button with action handler
                let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
                    print("Confirm button tapped")
                    var inputText = dialogMessage.textFields![0].text
                    //print(dialogMessage.textFields![0].text)
                    
                    if inputText == String(self.pin) {
                        print("good job")
                        self.SignIn.isHidden = false
                }
                    
                    else {
                        print("bad job")
                    }
                    
               })
                
                // Create Cancel button with action handlder
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                    print("Cancel button tapped")
                }
                
                //Add OK and Cancel button to dialog message
                dialogMessage.addAction(confirm)
                dialogMessage.addAction(cancel)
                
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
    }
    
    @IBAction func signInAppear(_ sender: Any) {
        signUp()
        
    }
    
   
    func didRegisterAccountValidation(input: String?) -> Bool {
        var validInput = false
        if input != nil && input != "" && !input!.isEmpty {
            validInput = true
        }
        return validInput
    }
    
func didRegisterAccountNewUser(username: String) -> Bool {
    let newUser = !DBHelperUser.dbHelperUser.isUserRegistered(username: username)
    return newUser
}
    
//    func regexPasswordValidation() -> Bool {
//
//                //At least Eight characters + One capital    + One lowercase  + One number  + One special character
//        let passwordPattern = #"(?=.{8,})"# + #"(?=.[A-Z])"# + #"(?=.[a-z])"# + #"(?=.\d)"# + #"(?=.[ !$%&?._-])"#
//
//
//        let passwordPatternRegex = try! NSRegularExpression(pattern: passwordPattern)
//        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordPatternRegex)
//
//        return passwordCheck.evaluate(with: passwordPattern)
//
//    }
//
//    func regexEmailValidation() -> Bool {
//
//        let emailPatternRegex = try! NSRegularExpression(pattern: #"^\S+@\S+.\S+$"#)
//        let emailCheck = NSPredicate(format: "SELF MATCHES %@",emailPatternRegex)
//
//        return emailCheck.evaluate(with: emailPatternRegex)
//    }

    func regexCredentials(username: String, password: String, repassword: String) -> Bool {
        var validation = false
        if !validUsername(username: username) {
            self.errorMessage.text = "Enter a valid email."
            print("first")
        }
        else if !passwordLength(password: password) {
                self.errorMessage.text = "Enter a password with at least 8 characters"
                print("second")
            }
            else if !passwordStrength(password: password) {
                    //self.errorMessage.text = "Need 1 uppercase, 1 lowercase, 1 number, 1 special character."
                    print("third")
                }
                else if !passwordMatch(password: password, repassword: repassword) {
                        self.errorMessage.text = "Passwords do not match."
                        print("fourth")
                    }
                    else {
                        validation = true
                        print("nice")
                    }
        return validation
    }
    
    func validUsername(username: String) -> Bool {
        let usernamePatternRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return regexValidation(value: username, regex: usernamePatternRegex)
    }
    
    func passwordLength(password: String) -> Bool {
        var longPassword = false
        if password.count >= 8 {
            longPassword = true
        }
        return longPassword
    }
    
    func passwordStrength(password: String) -> Bool {
        var strPassword = false
        
        let capitalPassword = regexValidation(value: password, regex: ".*[A-Z]+.*")
        let lowerPassword = regexValidation(value: password, regex: ".*[a-z]+.*")
        let numberPassword = regexValidation(value: password, regex: ".*[0-9]+.*")
        let specialPassword = regexValidation(value: password, regex: ".*[!@#$&]+.*")
        
        if capitalPassword && lowerPassword && numberPassword && specialPassword  {
            strPassword = true
        }
        else {
            self.errorMessage.text = "Need 1 uppercase, lowercase, number, special character."
        }
        return strPassword
    }
    
    func passwordMatch(password: String, repassword: String) -> Bool {
     return password == repassword
    }
    
    func regexValidation(value: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }

//    func test() {
//        errorMessage.text = "HELP"
//    }
    
func signUp() {
    
    //errorMessage.text = "HELP"
    let name = enterNameTextField.text!
    let username = enterEmailTextField.text!
    let password = enterPasswordTextField.text!
    let reEnterPassword = ReEnterPasswordTextField.text!
    let mobile = mobileNumberTextField.text!
    
    
    
    
    
            //At least Eight characters + One capital    + One lowercase  + One number  + One special character
    //let passwordPattern = #"(?=.{8,})"# + #"(?=.[A-Z])"# + #"(?=.[a-z])"# + #"(?=.\d)"# + #"(?=.[ !$%&?._-])"#
    
    // Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
//    let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
//    let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: enterPasswordTextField.text)
    
    //let emailPatternRegex = try! NSRegularExpression(pattern: #"^\S+@\S+.\S+$"#)
    //let passwordPatternRegex = try! NSRegularExpression(pattern: passwordPattern)
        
    if !(didRegisterAccountValidation(input: name) && didRegisterAccountValidation(input: username) && didRegisterAccountValidation(input: password) && didRegisterAccountValidation(input: reEnterPassword) && didRegisterAccountValidation(input: mobile)) {
        self.errorMessage.text = "Please input credentials."
        
    } else if !regexCredentials(username: username, password: password, repassword: reEnterPassword) {
           // self.errorMessage.text = "HELP"
        }
    
        else if DBHelperUser.dbHelperUser.isUserRegistered(username: username) {
                self.errorMessage.text = "You registered already, go to log in page."
            
            } else {
                DBHelperUser.dbHelperUser.createUser(nameValue: name, emailValue: username, passwordValue: password, reEnterPasswordValue: reEnterPassword, mobileValue: mobile)
                self.errorMessage.text = "Registered succesfully! Please log in."
            }
}
    

//func saveDataToKeyChain() {
//    if rememberMe.isOn {
//        //save user data to keychain
//
//        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : enterEmailTextField.text!]
//
//        let attributeUsername: [String: Any] = [kSecAttrAccount as String: enterEmailTextField!]
//
//        let attributePassword: [String: Any] = [kSecValueData as String: enterPasswordTextField.text!.data(using: .utf8)!]
//
//        if SecItemUpdate(request as CFDictionary, attributePassword as CFDictionary) == noErr && SecItemUpdate(request as CFDictionary, attributeUsername as CFDictionary) == noErr  {
//            print("User data saved in keychain.")
//        } else {
//            print("Error.")
//        }
//        //save this user to userDefaults
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(enterEmailTextField.text!, forKey: "UserRemembered")
//        }
//    if rememberMe.isOn == false {
//        let request: [String: Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String: enterEmailTextField.text!]
//
//        if SecItemDelete(request as CFDictionary) == noErr {
//            print("User data deleted.")
//        }
//        else {
//            print("Error.")
//        }
//    }
//
//    }
}
