//
//  Search+CoreDataClass.swift
//  Gaurashtra
//
//  Created by Sunish Ram on 16/08/19.
//  Copyright © 2019 Gaurashtra. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Search)
public class Search: NSManagedObject {
    
    static func getAllSearchList() -> [Search]
    {
        let managedObjectContext = kSharedAppDelegate.managedObjectContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Search", in: managedObjectContext) else { return [] }
        fetchRequest.entity = entityDescription
        
        do
        {
            let result = try managedObjectContext.fetch(fetchRequest)
            guard let arrSearchData = result as? [Search] else
            {
                return []
            }
            return arrSearchData
        }
        catch let error
        {
            print_debug(items: error)
        }
        return []
    }
    
    static func getExistSearch(withSearchName name: String) -> Search?
    {
        let managedObjectContext = kSharedAppDelegate.managedObjectContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Search", in: managedObjectContext) else { return nil }
        fetchRequest.entity = entityDescription
        //        let pre = "name == " + name
        //        fetchRequest.predicate = NSPredicate.init(format: "name == \(String.getString(name))")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name) //NSPredicate.init(format: pre)
        
        do
        {
            let result = try managedObjectContext.fetch(fetchRequest)
            guard let arrSearchData = result as? [Search] else
            {
                return nil
            }
            return arrSearchData.first
        }
        catch let error
        {
            print_debug(items: error)
        }
        return nil
    }
    
    static func addOrUpdateSearchData(withSearchName name: String)
    {
        let managedObjectContext = kSharedAppDelegate.managedObjectContext()
        
        guard  let existingSearchData = Search.getExistSearch(withSearchName: name)  else{
            guard let saveSearchData = NSEntityDescription.insertNewObject(forEntityName: "Search", into: managedObjectContext) as? Search else
            {
                return
            }
            
            saveSearchData.name = name
            
            
            return
        }
        
        existingSearchData.name = name
        kSharedAppDelegate.saveContext()
    }
    static func addSearchData(withSearchName name: String) -> Search?
    {
        let managedObjectContext = kSharedAppDelegate.managedObjectContext()
        guard let existingSearchData = Search.getExistSearch(withSearchName: String.getString(name))
            else
        {
            guard let Search = NSEntityDescription.insertNewObject(forEntityName: "Search", into: managedObjectContext) as? Search else
            {
                return nil
            }
            Search.name = name
           
            
            kSharedAppDelegate.saveContext()
            return Search
        }
        return existingSearchData
    }
    static func addSearchDatabase(withSearchName name: String) -> Search?
    {
        let managedObjectContext = kSharedAppDelegate.managedObjectContext()
        guard let saveSearchData = NSEntityDescription.insertNewObject(forEntityName: "Search", into: managedObjectContext) as? Search else
        {
            return nil
        }
        saveSearchData.name = name
       
        
        kSharedAppDelegate.saveContext()
        return saveSearchData
        
    }
    
    
//    static func deleteAllData()
//    {
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Search")
//        let request = NSBatchDeleteRequest(fetchRequest: fetch)
//
//        let result = try managedObjectContext.executeRequest(request)
//    
//    }
    
    static func deleteSearchData(withSearchName name: String)
    {
        let managedObjectContext = kSharedAppDelegate.managedObjectContext()
        guard let existingSearchData = Search.getExistSearch(withSearchName: name) else
        {
            return
        }
        managedObjectContext.delete(existingSearchData)
        kSharedAppDelegate.saveContext()
    }
    

}
