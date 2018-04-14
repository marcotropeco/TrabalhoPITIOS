//
//  consultaManager.swift
//  IOSFINAL
//
//  Created by COTEMIG on 19/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//

import Foundation
import CoreData

class ConsultaManager {
    
    
    
    static let shared = ConsultaManager()
    
    var consultas : [Consulta]!
    
    
    func loadConsultaTipo(tipo:Int, with context: NSManagedObjectContext) -> [Consulta]? {
        
        let fetchRequest : NSFetchRequest<Consulta> = Consulta.fetchRequest()
        
        let preferences = UserDefaults.standard
        
        
        if tipo==1 {
            fetchRequest.predicate = NSPredicate(format: "email = %@ and tipo=%@", preferences.string(forKey: "emailtrabiosmact")!,"BitCoin")
        } else  if tipo==2 {
            fetchRequest.predicate = NSPredicate(format: "email = %@ and tipo=%@", preferences.string(forKey: "emailtrabiosmact")!,"LetCoin")
        }else{
           fetchRequest.predicate = NSPredicate(format: "email = %@", preferences.string(forKey: "emailtrabiosmact")!)
        }
        
        
        //let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        do {
            
            try self.consultas = context.fetch(fetchRequest)
            
        } catch {
            
            print(error.localizedDescription)
            
            return nil
            
        }
        
        
        
        return self.consultas
        
    }
    
    
    func loadConsulta(with context: NSManagedObjectContext) -> [Consulta]? {
        
        let fetchRequest : NSFetchRequest<Consulta> = Consulta.fetchRequest()
        
        let preferences = UserDefaults.standard
        fetchRequest.predicate = NSPredicate(format: "email = %@", preferences.string(forKey: "emailtrabiosmact")!)
        //let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]

        
        do {
            
            try self.consultas = context.fetch(fetchRequest)
            
        } catch {
            
            print(error.localizedDescription)
            
            return nil
            
        }
        
        
        
        return self.consultas
        
    }
    
    
    
    func saveConsulta(_ consulta: Consulta, with context: NSManagedObjectContext) -> Bool? {
        
        
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error.localizedDescription)
            
            return false
            
        }
        
        
        return true
        
    }
    
    
    
    func deleteConsulta(_ consulta: Consulta, with context: NSManagedObjectContext) -> Bool {
        
        context.delete(consulta)
        
        
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error.localizedDescription)
            
            return false
            
        }
        
        
        
        return true
        
    }
    
}
