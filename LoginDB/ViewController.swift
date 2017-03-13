//
//  ViewController.swift
//  LoginDB
//
//  Created by Mitosis on 22/02/17.
//  Copyright © 2017 Mitosis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var useremail: UITextField!
    
    @IBOutlet var userpass: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func  displayMyAlert(_ userMessage:String)
    {
        let myAlert=UIAlertController(title:"Alert",message: userMessage,preferredStyle: UIAlertControllerStyle.alert);
        let okAction=UIAlertAction(title:"ok",style:UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion:nil);
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
    
    //Validate End
    
    
    
    //Regular Login
    @IBAction func btnLogin(_ sender: AnyObject) {
        
       
        if(isValidEmail(useremail.text!) && validate(userpass.text!) )
        {
              checkUser(emailid: useremail.text!, pass: userpass.text!)
   
        }
            
        else{
            displayMyAlert("Login Failed! Enter Correct Email and Password");
            return;
            
        }

        
        
       
        
        
    }
   
        
    func checkUser(emailid: String,pass: String){
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let  request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        let predicate = NSPredicate(format: "email == %@", useremail.text!)
            let predicate2 = NSPredicate(format: "password == %@", userpass.text!)
        request.predicate = predicate
            request.predicate = predicate2
        request.returnsObjectsAsFaults = false
            
        do{
            let results  = try context.fetch(request)
            print(results)
            if results.count>0
            {
                for result in results as! [NSManagedObject]
                {
                 
                   let stremail = result.value(forKey: "email") as! String
                    let strpassword = result.value(forKey: "password") as! String
                   if( stremail == emailid && strpassword == pass) {
                        print("Success")
                    performSegue(withIdentifier: "LoginView", sender: self)
                    }
                    else{ print("Failed")
                    displayMyAlert("Login Failed! Email or Password do not match");
                    return;
                    
                }
                  
                }
            }
            
            else{print("Failed. No result")
                displayMyAlert("Login Failed! Incorrect email. Please register.");
                return;}
            }
      
    
    catch(let error as NSError) {
    
    print("Could not save \(error), \(error.userInfo)")
    }
 }
}

