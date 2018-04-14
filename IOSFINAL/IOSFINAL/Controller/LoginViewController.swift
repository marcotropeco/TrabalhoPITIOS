//
//  LoginViewController.swift
//  IOSFINAL
//
//  Created by COTEMIG on 08/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtsenha: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBAction func btnlogar(_ sender: Any) {
        
        if txtemail.text?.isEmpty == false &&
            txtsenha.text?.isEmpty == false {
        
            if (txtemail.text?.isEmail)!{
            
                do {
                   try logar()
    
                }catch let error {
                    print(error.localizedDescription)
                }
            }else{
                self.displayAlertMessage(userMessage: "Informe um e-mail valido!")
            }
        }else{
            if txtemail.text?.isEmpty == true{
                showAlert(message : "O e-mail deve ser informado!")
                
            }else if txtsenha.text?.isEmpty == true{
                
                showAlert(message : "A senha deve ser informada!")
                
            }
            
        }
    }
    
    func logar() throws {
        
        if  UsuarioManager.shared.getQuantidadeUsuarioMailorPassword(email: txtemail.text!,senha: txtsenha.text!,with: context) == 1 {
            
            let preferences = UserDefaults.standard
            preferences.set("S", forKey: "logadotrabiosmact")
            preferences.set(self.txtemail.text, forKey: "emailtrabiosmact")
            
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "view2") as! UITabBarController
            
            self.present(vc, animated: true, completion: nil)
            
            
        }else{
            showAlert(message : "Ocorreu um erro ao autenticar, e-mail ou senha inválidos!")
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
