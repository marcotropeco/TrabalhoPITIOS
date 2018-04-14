//
//  ConsultabitcoinViewController.swift
//  IOSFINAL
//
//  Created by Marco Aurélio Domingos Costa on 11/03/2018.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class ConsultabitcoinViewController: UIViewController {
    @IBOutlet weak var lbultimaconsulta: UILabel!
    @IBOutlet weak var lbvalor: UILabel!
    
    @IBOutlet weak var viLoad: UIView!
    @IBAction func btconsultar(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let dateInFormat = "Hora da ultima consulta : " + dateFormatter.string(from: NSDate() as Date)
        let preferences = UserDefaults.standard
        var permiteconsultatime = false;
        var elapsedTime : Double = 0
        
        if preferences.integer(forKey: "horaconsultatrabiosmact") > 0 {
            elapsedTime = NSDate.timeIntervalSinceReferenceDate - preferences.double(forKey: "horaconsultatrabiosmact")
            if elapsedTime > 60 {
                permiteconsultatime = true
            }
        }else{
            permiteconsultatime = true
        }
        
        if permiteconsultatime == true {
            
                viLoad.isHidden = false
                let urlApi = "ticker/btc-brl"
                RestApiManager.load(url: urlApi) { (tickers) in
                    
                    if (tickers?.base) != nil {
                        
                        preferences.set( NSDate.timeIntervalSinceReferenceDate, forKey: "horaconsultatrabiosmact")
                       
                        let valorprice = String(format: "%.2f", Double((tickers?.price)!)!)
                        self.lbvalor.text = valorprice
                        
                       
                        preferences.set(valorprice,forKey: "pricebittrabiosmact")
                        preferences.set(dateInFormat,forKey: "ultimaconsultatrabiosmact")
                        self.lbultimaconsulta.text = dateInFormat
                        self.viLoad.isHidden = true
                        
                        let objConsulta = Consulta(context : self.context)
                        objConsulta.email = preferences.string(forKey: "emailtrabiosmact")
                        objConsulta.tipo = "BitCoin"
                        objConsulta.informacao = "Data/Hora :"+dateFormatter.string(from: NSDate() as Date) + " - R$ " + valorprice
                        
                        if (!ConsultaManager.shared.saveConsulta(objConsulta, with: self.context)!){
                            self.showAlert(message : "Ocorreu um erro ao salvar a consulta!")
                        }
                        
                        return
                        
                    } else {
                        //let alert = UIAlertController(title: "Atenção", message: "Não foi possível carregar o valor.", preferredStyle: .alert)
                        // alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.viLoad.isHidden = true
                        self.showAlert(message :  "Não foi possível realizar a consulta, aguarde ou tente mais tarde!")
                        return
                    }
                    
                }
            }else{
                self.showAlert(message : "O limite de consultas e de 1 minuto , por favor aguarde " + String(format: "%.0f",(60 - elapsedTime)) + " Segundos!")
                return
            }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viLoad.isHidden = true
        
        let preferences = UserDefaults.standard
       
        if preferences.string(forKey: "pricebittrabiosmact") != nil{
            self.lbvalor.text = preferences.string(forKey: "pricebittrabiosmact")
        }else{
            self.lbvalor.text = ""
        }
        
        if preferences.string(forKey: "ultimaconsultatrabiosmact") != nil{
            self.lbultimaconsulta.text = preferences.string(forKey: "ultimaconsultatrabiosmact")
        }else{
            self.lbultimaconsulta.text = ""
        }

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
