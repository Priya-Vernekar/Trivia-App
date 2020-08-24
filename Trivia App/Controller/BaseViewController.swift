//
//  BaseViewController.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit
import SQLite3

class BaseViewController: UIViewController, UINavigationControllerDelegate {
    
    var db: OpaquePointer? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getDatabaseConnection() {
        db = openDatabase()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
    func setNavBackTitle(title: String) {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = title
        backButtonItem.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("TriviaDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        } else {
            print("DB opened")
        }
        return db
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS GameInfoTable(" + "Id INTEGER PRIMARY KEY AUTOINCREMENT," + "Name TEXT,"  + "BestCricketer TEXT," + "FlagColors TEXT," + "Date TEXT" + ")"
        
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("\nGameInfoTable table created.")
            } else {
                print("\nUnable to create GameInfoTable table")
            }
        } else {
            print("\nCREATE TABLE statement is not prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func getDateString(format: String, date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    
    
}
