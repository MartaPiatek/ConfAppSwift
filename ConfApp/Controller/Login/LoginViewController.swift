//
//  LoginViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 13.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.setBottomBorder(borderColor: UIColor.white)
        emailTextField.setBottomBorder(borderColor: UIColor.white)
        self.hideKeyboardWhenTappedAround()
       // self.navigationController?.navigationItem.leftBarButtonItem?.title = "title"
     
        self.emailTextField.text = "user@gmail.com"
        self.passwordTextField.text = "user123"
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
   /*
        Auth.auth().addStateDidChangeListener() { auth, user in
            
            if user != nil {
             
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
 */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func login(sender: UIButton){
        
        //walidacja czy pola nie są puste
        guard let emailAddress = emailTextField.text, emailAddress != "",
            let password = passwordTextField.text, password != "" else {
                
                let alertController = UIAlertController(title: "Błąd logowania", message: "Pola nie mogą być puste", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // logowanie do konta w Firebase
        
        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: { (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Błąd logowania", message: error.localizedDescription, preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            
            
            self.view.endEditing(true)
            
           
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let navVc = segue.destination as! UINavigationController
        let channelVc = navVc.viewControllers.first as! ChannelListViewController 
        
        channelVc.senderDisplayName = Auth.auth().currentUser?.displayName
       // channelVc.senderId = Auth.auth().currentUser?.uid
    }
*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

