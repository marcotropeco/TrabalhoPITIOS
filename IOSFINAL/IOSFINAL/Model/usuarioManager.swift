//
//  usuarioManager.swift
//  IOSFINAL
//
//  Created by COTEMIG on 08/03/18.
//  Copyright © 2018 Vitor. All rights reserved.
//
import Foundation
import CoreData

class UsuarioManager {
    
    
    
    static let shared = UsuarioManager()
    
    var usuarios : [Usuario]!
    
    //context.reset()
    
    func getQuantidadeUsuarioMailorPassword(email: String, senha: String ,with context: NSManagedObjectContext) -> Int {
        
        let fetchRequest : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        var utilizaemail = false
        if !email.isEmpty {
            utilizaemail = true
        }
        
        var utilizasenha = false
        if !senha.isEmpty {
            utilizasenha = true
        }
        
        if utilizaemail && utilizasenha {
            fetchRequest.predicate = NSPredicate(format: "email = %@ and senha = %@",email,senha)
        }else if utilizaemail{
            fetchRequest.predicate = NSPredicate(format: "email = %@ ",email)
        }
        
        do {
            
            try self.usuarios = context.fetch(fetchRequest)
            
        } catch {
            
            print(error.localizedDescription)
            
            return 0
            
        }
        
        
        
        return self.usuarios.count
        
    }
    
    func loadUsuario(with context: NSManagedObjectContext) -> [Usuario]? {
        
        let fetchRequest : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        
        //let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        
        do {
            
            try self.usuarios = context.fetch(fetchRequest)
            
        } catch {
            
            print(error.localizedDescription)
            
            return nil
            
        }
        
        
        
        return self.usuarios
        
    }
    
    
    
    
    func updateUsuario(_ usuario: Usuario, with context: NSManagedObjectContext) -> Bool? {
        
        let senha = usuario.senha
        let fetchRequest : NSFetchRequest<Usuario> = Usuario.fetchRequest()
        let preferences = UserDefaults.standard
        fetchRequest.predicate = NSPredicate(format: "email = %@", preferences.string(forKey: "emailtrabiosmact")!)
        
    
        do {
            try self.usuarios = context.fetch(fetchRequest)
            if usuarios?.count == 1
            {
                
                usuarios[0].setValue(senha, forKey: "senha")
               
                try context.save()
                return true
            }
        } catch {
            
            print(error.localizedDescription)
            
            return false
            
        }
        
        
        return false
        
    }
    
    func saveUsuario(_ usuario: Usuario, with context: NSManagedObjectContext) -> Bool? {
        
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error.localizedDescription)
            
            return false
            
        }
        
        
        return true
        
    }
    
    
    
    func deleteUsuario(_ usuario: Usuario, with context: NSManagedObjectContext) -> Bool {
        
        context.delete(usuario)
        
        
        
        do {
            
            try context.save()
            
        } catch {
            
            print(error.localizedDescription)
            
            return false
            
        }
        
        
        
        return true
        
    }
    
    
    
}
