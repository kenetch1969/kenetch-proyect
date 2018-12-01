//
//  CoreDataStock.swift
//  CoreDataConcept
//
//  Created by Juan Gerardo Cruz on 11/3/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//
/*
 NSManagedObject: Representa cada fila/tupla de una tabla. Será el objeto que utilicemos para representar cada instancia de una Entidad. Por ejemplo, de una tabla Personaje, cada NSManagedObject será una instancia de un personaje.
 
 NSManagedObjectContext: Este es muy importante, ya que es la plataforma que ‘sostiene’ todos nuestros NSManagedObject. Representa todo nuestro modelo en memoria. A él le pediremos que haga búsquedas o que guarde los cambios que hayamos hecho en el modelo. Ten en cuenta que hasta que no le demos la orden de guardar no escribirá los datos en disco, sino que los mantendrá en memoria, así que más te vale llevarte bien con él antes de que se cierre la app.
 
 NSEntityDescription: Describe una entidad de CoreData.
 
 NSManagedObjectModel: Es el mapa de entidades que hemos creado anteriormente en el asistente gráfico. Él tiene la definición de cómo es nuestra base de datos. Normalmente la burocracia nos mantiene alejados de esta clase.
 
 NSFetchRequest: En lo que se refiere a búsquedas, este es el p*** amo. Pídele lo que quieras, que irá al contexto a traértelo en un santiamén, de la entidad que quieras y ordenado como te dé la gana. Además, con la ayuda de un NSPredicate, podrás filtrar los resultados como un señor.
 
 NSPredicate: Este no es típicamente de CoreData sino que está dentro de Cocoa y sirve para filtrar cualquier tipo de colección con resultados diversos. Aprende a usarlo y lo agradecerás en el futuro.
 
 NSPersistentStoreCoordinator: Aunque el Contexto (NSManagedObjectContext) sea quien reciba la orden de guardar los datos en disco, es esta instancia la que  hace realmente el trabajo duro. Ella es quien se relaciona con los contextos (sí, podemos tener varios) y con las bases de datos (sí, has leído bien, también está en plural). En una aplicación sencilla solo usaremos uno, y ni siquiera recordaremos que existe…
 
 */

import Foundation
import CoreData

class CoreDataStock {
    
    private lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    var managedObjectModel: NSManagedObjectModel?
    var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    var managedObjectContext: NSManagedObjectContext?
    
    
    func DataManagedObjectContext() -> NSManagedObjectContext? {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.DataPersistentStoreCoordinator()
        if coordinator == nil {
            return nil
        }
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }
    
    func DataPersistentStoreCoordinator() -> NSPersistentStoreCoordinator? {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.DataManagedObjectModel())
        let url = self.applicationDocumentsDirectory.appendingPathComponent("Model.sqlite")
        let failureReason = "There was an error creating or loading the application's saved data."
        do {
            // Configure automatic migration.
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
        
    }
    
    func DataManagedObjectModel() -> NSManagedObjectModel{
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    func saveContext () {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext?.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}


