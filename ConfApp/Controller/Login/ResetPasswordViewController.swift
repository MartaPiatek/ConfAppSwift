//
//  ResetPasswordViewController.swift
//  ConfApp
//
//  Created by Marta Piątek on 15.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.setBottomBorder(borderColor: UIColor.white)
        self.hideKeyboardWhenTappedAround()
        assignbackground()
        
      self.emailTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPassword(sender: UIButton) {
        
        guard let emailAddress = emailTextField.text,
            emailAddress != "" else {
                
                let alertController = UIAlertController(title: "Błąd wprowadzania danych", message: "Wprowadź adres email, aby zresetować hasło", preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
                
        }
        
        // wyslij email resetujący hasło
        
        Auth.auth().sendPasswordReset(withEmail: emailAddress, completion: { (error) in
            
            let title = (error == nil) ? "Resetowanie hasła" : "Błąd resetowania hasła"
            
            let message = (error == nil) ? "Wysłaliśmu email resetujący hasło. Proszę sprawdź swoją skrzynkę i postępuj zgodnie z instrukcjami"
            : error?.localizedDescription
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                
                if error == nil {
                    
                    self.view.endEditing(true)
                    
                    //powrot do ekranu logowania
                    
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            })
            alertController.addAction(okayAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        })
    }
    func assignbackground(){
        let background = UIImage(named: "background2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        imageView.alpha = 1
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

