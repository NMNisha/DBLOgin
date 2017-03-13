//
//  Register.swift
//  LoginDB
//
//  Created by Mitosis on 22/02/17.
//  Copyright © 2017 Mitosis. All rights reserved.
//

import UIKit
import CoreData

class Register: UIViewController {

    @IBOutlet var username: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!

    @IBOutlet var cnfmpass: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isValidEmail(_ testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    
    func validate(_ value: String) ->  Bool {
        
        let PASS_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{8,}$" //Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
        let passTest = NSPredicate(format: "SELF MATCHES %@", PASS_REGEX)
        let result =  passTest.evaluate(with: value)
        return result
    }


    func  displayMyAlert(_ userMessage:String)
    {
        let myAlert=UIAlertController(title:"Alert",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let okAction=UIAlertAction(title:"ok",style:UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
    }
    
    @IBAction func btnSubmit(_ sender:AnyObject) {
        
        let name = self.username.text
        let emailid = email.text
        let pwd = password.text
        let cnfmpwd = cnfmpass.text
        
        if(name!.isEmpty || emailid!.isEmpty || pwd!.isEmpty || cnfmpwd!.isEmpty)
        {
            displayMyAlert("All Fields are required");
            return;
        }
        
        
        else if((pwd==cnfmpwd) && isValidEmail(emailid!) && validate(pwd!))
        {
           self.SaveUser(data: username.text!)
             self.SaveUser(data: email.text!)
            self.SaveUser(data: password.text!)
            performSegue(withIdentifier: "btnSubmit", sender: sender)
        }
        else{
            displayMyAlert("Enter correct Email and Password");
            
        }
    }
    
    
    func SaveUser(data:String){
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let newuser =  NSEntityDescription.insertNewObject(forEntityName: "Users", into: managedContext)
        
        
        newuser.setValue(username.text, forKey: "name")
        newuser.setValue(email.text, forKey: "email")
        newuser.setValue(password.text, forKey: "password")
    
    
        
        
        do {
            try managedContext.save()
            print("saved")
            print(newuser)
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    


}
