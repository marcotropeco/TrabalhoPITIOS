//
//  ConsultaTableViewController.swift
//  IOSFINAL
//
//  Created by COTEMIG on 19/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//

import UIKit

class ConsultaTableViewController: UITableViewController {

    @IBAction func sgtconsulta(_ sender: UISegmentedControl) {
        
        
        self.consultas = ConsultaManager.shared.loadConsultaTipo(tipo : sender.selectedSegmentIndex ,with: self.context)!
        self.tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title="Consulta(s)"
        
        
    }
    
    var consultas = [Consulta]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    func loadPlaces() {
        self.consultas = ConsultaManager.shared.loadConsulta(with: self.context)!
        self.tableView.reloadData()
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.topItem?.title="Consulta(s)"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlaces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.consultas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let consulta = self.consultas[indexPath.row]
        cell.textLabel?.text = consulta.informacao
    
        cell.detailTextLabel?.text = consulta.tipo
        cell.textLabel?.numberOfLines = 0
        tableView.rowHeight = UITableViewAutomaticDimension
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if (ConsultaManager.shared.deleteConsulta(self.consultas[indexPath.row], with: self.context)) {
                self.consultas.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

   

}
