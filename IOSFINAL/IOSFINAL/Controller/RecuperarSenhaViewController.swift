//
//  RecuperarSenhaViewController.swift
//  IOSFINAL
//
//  Created by COTEMIG on 19/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class RecuperarSenhaViewController: UIViewController {

    @IBOutlet weak var txEmail: UITextField!
    @IBAction func btrecuperarSenha(_ sender: Any) {
        
        if( txEmail.text?.isEmail)!{
            
            if (txEmail.text?.isEmpty)! {
               self.showAlert(message :  "Infome um e-mail para recuperar a senha!")
            }else{
                self.showAlert(message : "As instruções para troca de senha foram enviadas por e-mail!")
            }
        }else{
            self.showAlert(message : "Informe um e-mail valido!")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


