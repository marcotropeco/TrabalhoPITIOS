//
//  bitcoinViewController.swift
//  IOSFINAL
//
//  Created by COTEMIG on 08/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController {
    
    @IBOutlet weak var lbultimaconsulta: UILabel!
    @IBOutlet weak var viLoad: UIView!
    @IBOutlet weak var lbvalor: UILabel!
    @IBOutlet weak var lblimiteconsulta: UILabel!
    var consultas : Int = 100;
    var tickers = [Ticker]()
    
    @IBAction func btconsultabitcoin(_ sender: UIButton) {
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            let dateInFormat = "Hora da ultima consulta : " + dateFormatter.string(from: NSDate() as Date)
            let preferences = UserDefaults.standard
            var permiteconsultatime = false;
            var elapsedTime : Double = 0
        
            if preferences.integer(forKey: "horaconsultatrabiosmact") >= 0 {
                elapsedTime = NSDate.timeIntervalSinceReferenceDate - preferences.double(forKey: "horaconsultatrabiosmact")
                if elapsedTime > 60 {
                    permiteconsultatime = true
                }
            }else{
                permiteconsultatime = true
            }
    
            if permiteconsultatime == true {
            
            
                    preferences.set( preferences.integer(forKey: "limitetrabiosmact"), forKey: "limitetrabiosmact")
                    var quantidade = self.consultas - ( preferences.integer(forKey: "limitetrabiosmact") + 1 )
                    if quantidade < 0 {
                        quantidade = 0
                    }
                    if quantidade > 0 {
                        viLoad.isHidden = false
                        let urlApi = "ticker/btc-brl"
                        RestApiManager.load(url: urlApi) { (tickers) in
                            
                            if (tickers?.base) != nil {
                                   
                                    preferences.set( NSDate.timeIntervalSinceReferenceDate, forKey: "horaconsultatrabiosmact")
                                    preferences.set( preferences.integer(forKey: "limitetrabiosmact")+1, forKey: "limitetrabiosmact")
                                    
                                    let valorprice = String(format: "%.2f", Double((tickers?.price)!)!)
                                    self.lbvalor.text = valorprice
                                    
                                    self.lblimiteconsulta.text = "Resta(m) : " + String(quantidade)
                                    
                                    preferences.set(valorprice,forKey: "pricebittrabiosmact")
                                    preferences.set(dateInFormat,forKey: "ultimaconsultatrabiosmact")
                                    self.lbultimaconsulta.text = dateInFormat
                                    self.viLoad.isHidden = true
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
                         // let alert = UIAlertController(title: "Atenção", message: "seu limite esgotou, registre para fazer novas consultas.", preferredStyle: .alert)
                         // alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                             self.showAlert(message :  "Seu limite de consultas esgotou, registre-se para fazer novas consultas.")
                        return
                    }
            }else{
                //let alert = UIAlertController(title: "Atenção", message: "O limite de consultas e de 1 minuto , por //favor aguarde!", preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.showAlert(message :  "O limite de consultas e de 1 minuto , por favor aguarde " + String(format: "%.0f",(60 - elapsedTime)) + " Segundos!")
                return
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {

        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            viLoad.isHidden = true
            
            let preferences = UserDefaults.standard
            var quantidade = consultas - preferences.integer(forKey: "limitetrabiosmact")
            if quantidade < 0 {
                quantidade = 0
            }
            self.lblimiteconsulta.text = "Resta(m) : " + String(quantidade)
            
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
