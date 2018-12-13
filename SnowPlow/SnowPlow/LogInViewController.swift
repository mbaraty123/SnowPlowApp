//
//  LogInViewController.swift
//  SnowPlow
//
//  Created by Michael Baraty on 12/12/18.
//  Copyright © 2018 Baraty Hannibal Enterprises. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    
    @IBOutlet fileprivate var signInUsernameField: UITextField!
    @IBOutlet fileprivate var signInPasswordField: UITextField!
    @IBOutlet fileprivate var signUpUsernameField: UITextField!
    @IBOutlet fileprivate var signUpPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInUsernameField.text = ""
        signInPasswordField.text = ""
        signUpUsernameField.text = ""
        signUpPasswordField.text = ""
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadHomeScreen()
        }
    }
    @IBAction func signIn(_ sender: UIButton) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logInWithUsername(inBackground: signInUsernameField.text!, password: signInPasswordField.text!) { (user, error) in
            UIViewController.removeSpinner(spinner: sv)
            if user != nil {
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: (descrip))
                }
            }
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let user = PFUser()
        user.username = signUpUsernameField.text
        user.password = signUpPasswordField.text
        let sv = UIViewController.displaySpinner(onView: self.view)
        user.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            if success{
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }
            }
        }
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadHomeScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let selectorViewController = storyBoard.instantiateViewController(withIdentifier: "SelectorViewController") as! SelectorViewController
        self.present(selectorViewController, animated: true, completion: nil)
    }

}
