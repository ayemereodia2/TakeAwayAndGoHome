//
//  DBHelper.swift
//  TakeAway
//
//  Created by Ayemere  Odia  on 20/02/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import Foundation
import SQLite

class DBHelper {
    
    // MARK: - Singleton
    static let shared = DBHelper()
    private  let db: Connection?
    
    
    // MARK: - DB Table
    private let favourite = Table("favourite")
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let status = Expression<String>("status")
   
    
    
    private init() {
        
        do {
            
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = directory.appendingPathComponent("Store").appendingPathExtension("sqlite3")
            
            db = try Connection(fileUrl.path)
            
        } catch {
            db = nil
            print ("Unable to open database")
        }
        createTable()
    }
    
    
    func createTable() {
        do {
            try db!.run(favourite.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(name)
                table.column(status)
            })
            
        } catch {
            print("Unable to create table")
        }
    }
    
    // MARK:- AllFavourite
    
    func getAllFavourite() -> [Favourite]{

        var products = [Favourite]()
        
        do {
            for fav in try db!.prepare(self.favourite) {
                products.append(Favourite(id: fav[id], name: fav[name], status:fav[status]))
            }
        } catch {
            print("Select failed")
        }
        return products
    }
    
    
    func addFavouritesToDb(_ favourite:Favourite)
    {
        do {
            let insert = self.favourite.insert(id <- favourite.id, name <- favourite.name , status <- favourite.status)
            try db!.run(insert)
                       print("added items to db")
            } catch let insertError{
             print(insertError)
        }
    }
    
    func removeFromFav(_ favourite:Favourite)
    {
    let fav = self.favourite.filter(self.name == favourite.name)
                   let deleted = fav.delete()
                   do{
                       try self.db?.run(deleted)
                   }catch let deletedError{
                print(deletedError)
            }
    }
}
