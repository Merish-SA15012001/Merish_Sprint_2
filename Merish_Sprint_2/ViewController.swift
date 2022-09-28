//
//  ViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/21/22.
//

import UIKit
import CoreData
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import LocalAuthentication

class ViewController: UIViewController {

//MARK: IBOutlet Start
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var LoginPassword: UITextField!
    @IBOutlet weak var LoginEmail: UITextField!
    //MARK: IBOutlet End
    override func viewDidLoad() {
        super.viewDidLoad()
        //authenticatepasscodeId()
        authenticatefaceid()
        
    }
   
    //MARK: IBAction Start
    @IBAction func loginbtn(_ sender: Any) {
     
        let email: String = LoginEmail.text!
        let pwsd: String =  LoginPassword.text!
        logintap(emailId: email, password: pwsd)
    }
    //MARK: IBAction end
    // function for authenticate face Id
    func authenticatefaceid(){
        let context = LAContext()
        var error: NSError?
        let reason = "To identify yourself"
        //analysing the biometrics of the user
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                
                if success{
                    self?.showalertMsg(msg: "Authentication done successfully", title: "success")
                }else{
                    
                }
                }}
        }
        else{
            showalertMsg(msg: "No biometric authentication available", title: "Error")
        }
        }
    // function for authenticate passcode Id
    func authenticatepasscodeId(){
        let context: LAContext = LAContext()
        let reason = "Authentication needed to access your App"
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError){
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: {success, error in
                if success{
                    print("user authed successfully")
                }
                else{
                    if let error = error {
                        let message = self.showErrorCodeMessage(errorCode: error as! Int)
                        print(message)
                    }
                }
            })
        }
            
    }
    // Function to show alert message
    func showalertMsg(msg: String, title: String){
        let alertmsg = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alertmsg.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertmsg, animated: true, completion: nil)
    }
    // function to show Errorcode message
    func showErrorCodeMessage(errorCode: Int) -> String{
        var msg = " "
        switch errorCode{
        case LAError.appCancel.rawValue:
            msg = "Authentication was cancelled by the application"
            
        case LAError.authenticationFailed.rawValue:
            msg = "Unable to authenticate the user"
            
        default:
            msg = "common error"
            
        }
        return msg
    }
    // function for login button tapped
    func logintap(emailId: String, password: String){
        Auth.auth().signIn(withEmail: emailId, password: password, completion: {
            (result, error) in
            if let error = error{
                print(error.self)
            }else{
                print("Login successful")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    )}
   
}
