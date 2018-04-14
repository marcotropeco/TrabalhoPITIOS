//
//  MainViewController.swift
//  IOSFINAL
//
//  Created by Marco Aurélio Domingos Costa on 18/03/2018.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        let preferences = UserDefaults.standard
        
        if let logado = preferences.string(forKey: "logadotrabiosmact"){
            
            if logado == "S"{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "view2") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
            }
        }
        
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

