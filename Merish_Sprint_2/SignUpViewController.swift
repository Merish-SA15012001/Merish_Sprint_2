//
//  SignUpViewController.swift
//  Merish_Sprint_2
//
//  Created by Capgemini-DA202 on 9/21/22.
//

import UIKit
import CoreData
import FirebaseAuth




class SignUpViewController: UIViewController {

    // MARK: IBOutlets Start
    @IBOutlet weak var Signup: UILabel!
    @IBOutlet weak var signupName: UITextField!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var signupEmail: UITextField!
    @IBOutlet weak var signupmobile: UITextField!
    @IBOutlet weak var signupPassword: UITextField!
    @IBOutlet weak var signupConfirmPassword: UITextField!
    // MARK: IBOutlets End
    
    // creating a context to access persistentContainer viewcontext
    let UserContext = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    //variables alert created to store different alert messages
    var alerts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Signupbtn(_ sender: Any) {
        // calling all the functions
        let duplicateEmail = checkEmail(emailid: signupEmail.text!)
        let names = validateName(nameText: signupName.text!)
        let checkemail = validateEmail(emailIdText: signupEmail.text!)
        let mobileNum = validateNumber(mobile: signupmobile.text!)
        let passwords = validatePassword(passtext: signupPassword.text!)
        let conpassword = isPasswordsame(passtext: signupPassword.text!, confirmpwdText: signupConfirmPassword.text!)
        
        if duplicateEmail && names && checkemail && mobileNum && passwords && conpassword == true {
            let userdetail = User(context: UserContext)
            userdetail.name = signupName.text
            userdetail.password = signupPassword.text
            userdetail.phoneNumber = signupConfirmPassword.text
            userdetail.emailid = signupEmail.text
            
            do{
                //calling save function
                try self.UserContext.save()
            }
            catch (let error) {
                print(error.localizedDescription)
            }
        }
        
        
        let email: String = signupEmail.text!
        let pwd: String = signupPassword.text!
        regUser(emailId: email, password: pwd)
        
    }
    
    func regUser(emailId: String, password: String){
        Auth.auth().createUser(withEmail: emailId, password: password, completion: {
            (result, error) -> Void in
            if let error = error{
                print(error.localizedDescription)
            }
            else{
                print("User Registered")
            }
        }
        
    )}
        // function to show alerts
    func showAlert(){
        
        guard alerts.count > 0 else{ return }
        let alertmessage = alerts.first
        
        func removeAlert(){
            self.alerts.removeFirst()
            self.showAlert()
        }
        let alertController = UIAlertController(title: "Alert", message: alertmessage, preferredStyle: .alert)
        alertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) {
        (action) in removeAlert()
        })
        self.present(alertController, animated: true)
    }
     // function to check duplicate email
    func checkEmail(emailid: String) -> Bool{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return 0 != 0}
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["emailid",emailid])
        
        var result: [NSManagedObject] = []
        do{
            result = try context.fetch(request)
            
            if result.count == 1 {
                alerts.append("Email Id already exists")
                showAlert()
            }
            
        }
        catch (let error) {
            print(error.localizedDescription)
        }
        return result.count == 0
    }
    // function to validate name
    func validateName(nameText: String) -> Bool {
        var res: Bool = false
        
        let regex = "^[A-Za-z](4,15}$"
        do{
            let expression = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let validName = expression.firstMatch(in: nameText, options: [], range: NSRange(location: 0, length: nameText.count)) != nil
            if validName{
                res = true
            }
            else{
                alerts.append("Name is invalid")
                showAlert()
            }
        }
        catch (let error){
            print(error.localizedDescription)
        }
        return res
    }
// function to validate email
    func validateEmail(emailIdText: String) -> Bool{
        var result: Bool = false
        let regex = "^[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}$"
        do{
            let exp = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let validEmail = exp.firstMatch(in: emailIdText, options: [], range: NSRange(location: 0, length: emailIdText.count)) != nil
            
            if validEmail{
                result = true
            }
            else{
                alerts.append("Email Id is invalid")
                showAlert()
            }
        }
        catch(let error){
                print(error.localizedDescription)
        }
        return result
    }
    // function to validate mobile number
    func validateNumber(mobile: String) -> Bool {
        var result: Bool = false
        let regex = "^[0-9]{10}$"
        do{
            let exp = try NSRegularExpression(pattern: regex)
            let validMobileNumber = exp.firstMatch(in: mobile,options: [], range: NSRange(location: 0, length: mobile.count)) != nil
            if validMobileNumber{
                result = true
            }
            else{
                alerts.append("phone number invalid")
                showAlert()
            }
        }
        catch(let error){
                print(error.localizedDescription)
        }
        return result
    }
    // function to validate password
    func validatePassword(passtext:String) -> Bool {
        var results: Bool = false
        let regex = "^(?=.*[A-Z])(?=.*[$@$#!%?&])(?=.*[0-9])(?=.*[a-z]).{6,15}$"
       
        let validpassword = NSPredicate(format: "SELF MATCHES %@", regex)
        if validpassword.evaluate(with: passtext){
        results.toggle()
        }
        else{
            alerts.append("Password is Invalid")
            
        }
        return results
    }
    // Function to check same password
    
    func isPasswordsame(passtext: String, confirmpwdText: String) -> Bool{
        var result: Bool = false
        if passtext == confirmpwdText && passtext.count > 0{
            result = true
            print("Password accepted")
            
        }
        else{
            alerts.append("Enter the confirm password correctly")
            showAlert()
        }
        return result
    }
}
