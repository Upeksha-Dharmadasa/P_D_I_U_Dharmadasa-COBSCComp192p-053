//
//  LoginViewController.swift
//  P_D_I_U_Dharmadasa-COBSCComp192p-053
//
//  Created by Upeksha Dharmadasa on 4/30/21.
//  Copyright © 2021 Upeksha Dharmadasa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if((UserDefaults.standard.bool(forKey: "Login")))
//        {
//            self.performSegue(withIdentifier: "RegisterCafeNIBM", sender: nil)
//        }

    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        Login()
    }
    
    @IBAction func btnRegister(_ sender: Any) {
              
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let vc = storyboard.instantiateViewController(identifier: "RegisterCafeNIBM")
               vc.modalPresentationStyle = .overFullScreen
               present(vc, animated: true)
    }
    
    @IBAction func btnForgetPassword(_ sender: Any) {
        
        ForgetPassword()
    }
    
    func LoginValidate()-> Bool{
        if txtEmail.text == ""{
                let alert = UIAlertController(title: "Error", message: "Enter a valid Email and Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false;
            }else if txtPassword.text == ""{
                let alert = UIAlertController(title: "Error", message: "Enter a valid Email and Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false;
            }
            else
            {
                return true;
            }
        }
    
    func   LoginVerify(){
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { [weak self] authResult, error in
            guard self != nil else {return}
            if let error = error {
                print(error.localizedDescription)
            }
            if Auth.auth().currentUser != nil {
                print(Auth.auth().currentUser?.uid ?? "")
                self!.performSegue(withIdentifier: "RegisterCafeNIBM", sender: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "Enter a valid Email and Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func Login()
    {
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
                let alert = UIAlertController(title: "Error", message: "Email is not allowed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            case .userDisabled:
                let alert = UIAlertController(title: "Error", message: "The user account has been disabled by an administrator.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            break
            case .invalidEmail:
                let alert = UIAlertController(title: "Error", message: "The email address is badly formatted.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            break
            case .wrongPassword:
                let alert = UIAlertController(title: "Error", message: "The user name or password is invalid", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            break
            
            default:
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Error: \(error.localizedDescription)")
            }
          } else {
                
//                 UserDefaults.standard.set(true, forKey: "Login")
//                self.performSegue(withIdentifier: "RegisterCafeNIBM", sender: nil)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "RegisterCafeNIBM" )
                       vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
          }
        }
    }

        func ForgetPassword()
           {
               if txtEmail.text?.isEmpty == true{
                   let alert = UIAlertController(title: "Error", message: "Please enter your email", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
                   return
               }
               
               Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { (error) in
                   
               if let error = error as NSError?
               {
                       switch AuthErrorCode(rawValue: error.code)
                       {
                       
                       case .invalidEmail:
                           let alert = UIAlertController(title: "Error", message: "Enter a valid mail", preferredStyle: .alert)
                                           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                           self.present(alert, animated: true, completion: nil)
                           break
                       
                           default:
                           let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription) ", preferredStyle: .alert)
                                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                       self.present(alert, animated: true, completion: nil)
                           print("Error: \(error.localizedDescription)")
                           
                           
                       }
                   
               }
                   
               else
               {
                   let alert = UIAlertController(title: "Reset", message: "Password reset link has been sent successfully to your email", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
               }
               
               return
           }
        
         }
    
}
    
