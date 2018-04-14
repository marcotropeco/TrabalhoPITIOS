//
//  AlterarSenhaViewController.swift
//  IOSFINAL
//
//  Created by Marco Aurélio Domingos Costa on 22/03/2018.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class AlterarSenhaViewController: UIViewController {
    
    
    @IBOutlet weak var txtconfsenha: UITextField!
    @IBOutlet weak var txtsenha: UITextField!
    
    @IBAction func btnlimpar(_ sender: Any) {
        txtsenha.text = ""
        txtconfsenha.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    @IBAction func btnalterar(_ sender: Any) {

        
        if txtconfsenha.text?.isEmpty == false &&
            txtsenha.text?.isEmpty == false {
            
                    if txtsenha.text==txtconfsenha.text{
                    
                        let objUsuario = Usuario(context : context)
                        objUsuario.senha = txtsenha.text ?? ""
                        if UsuarioManager.shared.updateUsuario(objUsuario, with: context)! {
                                showAlert(message : "A senha foi alterada com sucesso!")
                        }else{
                            showAlert(message : "Ocorreu um erro ao alterar a senha!")
                        }
                    
                    }else{
                         showAlert(message : "A senha deve ser igual a confirmação!")
                    }
                }else{
            
                    if txtsenha.text?.isEmpty == true{
                        
                        showAlert(message : "A senha deve ser informada!")
                        
                    }else if txtconfsenha.text?.isEmpty == true {
                        
                        showAlert(message : "A confirmação da senha deve ser informado!")
                    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title="Alterar Senha"
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
