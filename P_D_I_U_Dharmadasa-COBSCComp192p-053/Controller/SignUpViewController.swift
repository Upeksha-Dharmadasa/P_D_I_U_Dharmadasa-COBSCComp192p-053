//
//  SignUpViewController.swift
//  P_D_I_U_Dharmadasa-COBSCComp192p-053
//
//  Created by Upeksha Dharmadasa on 4/30/21.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        SignUp()
    }
    
    @IBAction func btnAlreadyRegister(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(identifier: "Login")
               vc.modalPresentationStyle = .overFullScreen
               self.present(vc, animated: true)
    }
    
    func emailValidate(_ txtEmail: String)-> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: txtEmail)
    }
               
    func passwordValidate(_ txtPassword: String) -> Bool
    {
        let minLength = 6
        return txtPassword.count >= minLength
        
    }
    
    func SignUp()
    {
          
          if txtEmail.text?.isEmpty == true
          {
              let alert = UIAlertController(title: "Error", message: "Email field cannot be empty", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              
              return
          }
          
         
          if !emailValidate(txtEmail.text!)
          {
              let alert = UIAlertController(title: "Error", message: "Enter a valid Email", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              return
          }
          
          if txtPassword.text?.isEmpty == true
                 {
                     let alert = UIAlertController(title: "Error", message: "Password cannot be empty", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
                     return
                 }
          
          if !passwordValidate(txtPassword.text!)
          {
              let alert = UIAlertController(title: "Error", message: "Enter a strong password", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              
              return
          }
          
         
          if txtConfirmPassword.text?.isEmpty == true
          {
              let alert = UIAlertController(title: "Error", message: "Please confirm your password", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              
              return
          }
          
          if (txtConfirmPassword.text != txtPassword.text)
          {
              let alert = UIAlertController(title: "Error", message: "Password mismatch", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              return
          }
          
          
          
          if txtPhone.text?.isEmpty == true
          {
              let alert = UIAlertController(title: "Error", message: "Please Enter Correct Phone Number", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
              
              return
          }
          
          
         Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
          
              if let error = error as NSError?
              {
                  
              switch AuthErrorCode(rawValue: error.code)
              {
              
              case .operationNotAllowed:
                  
                  let alert = UIAlertController(title: "Error", message: "Invalid Email", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                              self.present(alert, animated: true, completion: nil)
                  break
                  
              case .emailAlreadyInUse:
                  let alert = UIAlertController(title: "Error", message: "This email address is already in use by another account.", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                              self.present(alert, animated: true, completion: nil)
                  break
                
              case .invalidEmail:
                  let alert = UIAlertController(title: "Error", message: "The email address is badly formatted", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                              self.present(alert, animated: true, completion: nil)
                  break
                  
              case .weakPassword:
                  let alert = UIAlertController(title: "Error", message: "Password must be greater than 6 characters", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                              self.present(alert, animated: true, completion: nil)
                  break
                  
              default:
                  let alert = UIAlertController(title: "Error", message: "An error occured while performing this action", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                              self.present(alert, animated: true, completion: nil)
              }
          }
          
          else
          {
            let newUser = Auth.auth().currentUser
              _ = newUser?.email
              
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let vc = storyboard.instantiateViewController(identifier: "Thankyou")
              vc.modalPresentationStyle = .overFullScreen
              self.present(vc, animated: true)
              
          }
            return

      }
      
    }

}
