//
//  CadastroViewController.swift
//  IOSFINAL
//
//  Created by COTEMIG on 08/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit
import CoreData

class CadastroViewController: UIViewController {

    @IBOutlet weak var txtsenha: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtconfsenha: UITextField!

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
  
    @IBAction func btnregistrar(_ sender: UIButton) {
        //showAlert(message: "iniciando")
        
        do {
           
           try registrar()
            
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func registrar() throws {
        
        if txtemail.text?.isEmpty == false &&
            txtsenha.text?.isEmpty == false &&
            txtconfsenha.text?.isEmpty == false {
            
            if (txtemail.text?.isEmail)! {
                
                if txtsenha.text==txtconfsenha.text{
                    if UsuarioManager.shared.getQuantidadeUsuarioMailorPassword(email: txtemail.text!,senha: "",with: context) == 0 {
                        let objUsuario = Usuario(context : context)
                        objUsuario.email = txtemail.text ?? ""
                        objUsuario.senha = txtsenha.text ?? ""
                        
                        //print(objUsuario)
                        if ( UsuarioManager.shared.saveUsuario(objUsuario, with: context) == true ) {
                            showAlert(message : "O Cadastro foi realizado com sucesso!")
                        }else{
                            showAlert(message : "Ocorreu um erro ao salvar!")
                        }
                    }else{
                        showAlert(message : "O E-mail informado já existe, tente outro!")
                    }
                }else{
                    showAlert(message : "A senha deve ser igual a confirmação!")
                }
            }else{
                self.displayAlertMessage(userMessage: "Informe um e-mail valido!")
            }
        }else{
            
            //showAlert(message : "error else!")
            if txtemail.text?.isEmpty == true{
                showAlert(message : "O e-mail deve ser informado!")
                
            }else if txtsenha.text?.isEmpty == true{
                
                showAlert(message : "A senha deve ser informada!")
                
            }else if txtconfsenha.text?.isEmpty == true {
                
                showAlert(message : "A confirmação da senha deve ser informado!")
            }
        }
        
    }
    
    @IBAction func btnlimpar(_ sender: Any) {
        
        
       
    
        txtconfsenha.text = ""
        txtemail.text = ""
        txtsenha.text = ""
        
       /* do {
           let results = try UsuarioManager.shared.loadUsuario(with: context)
           let  dateCreated = results as! [Usuario]
            print(dateCreated.count)
            for _datecreated in dateCreated {
                print(_datecreated.email ?? "")
                print(_datecreated.senha ?? "")
                //print(_datecreated)
                
            }
            for _datecreated in dateCreated {
              // UsuarioManager.shared.deleteUsuario(_datecreated, with:  context)
         
            }
        }catch let err as NSError {
            print(err.debugDescription)
        }*/
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


