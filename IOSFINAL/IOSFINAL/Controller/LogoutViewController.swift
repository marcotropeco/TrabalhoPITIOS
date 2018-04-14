//
//  LogoutViewController.swift
//  IOSFINAL
//
//  Created by Marco Aurélio Domingos Costa on 11/03/2018.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true
    }

    @IBAction func logout(_ sender: Any) {
        
        let preferences = UserDefaults.standard
        preferences.set("N", forKey: "logadotrabiosmact")
        self.dismiss(animated: true, completion: nil)
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
