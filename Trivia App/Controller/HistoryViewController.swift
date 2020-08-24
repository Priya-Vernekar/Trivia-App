//
//  HistoryViewController.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit
import SQLite3

class HistoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var resultArray : [[String:String]] = []
    var showData : Bool = false
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDatabaseConnection()
        getAllGameDetails()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (showData) ? resultArray.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell
        cell?.gameNumberWithDateLabel.text = "GAME" + (resultArray[indexPath.row]["id"]!) + " : " + (resultArray[indexPath.row]["date"]!) + "\n"
        cell?.nameLabel.text = "Name" +  " : " + (resultArray[indexPath.row]["name"]!) + "\n"
        cell?.cricketerName.text = (resultArray[indexPath.row]["cricketer"]!) + "\n"
        cell?.flagColors.text = (resultArray[indexPath.row]["flagColors"]!) + "\n"
        cell?.selectionStyle = .none
        return cell!
    }
    
    func getAllGameDetails() {
        let queryStatementString = "SELECT * FROM GameInfoTable;"
        
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
                    return
                }
                guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
                    return
                }
                guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                    return
                }
                guard let queryResultCol4 = sqlite3_column_text(queryStatement, 4) else {
                    return
                }
                let name = String(cString: queryResultCol1)
                let cricketer = String(cString: queryResultCol2)
                let flagColors = String(cString: queryResultCol3)
                let date = String(cString: queryResultCol4)
                resultArray.append(["id":"\(id)","name":name,"cricketer":cricketer,"flagColors":flagColors,"date":date])
                
            }
            showData = true
            tableView.reloadData()
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        
    }
    
    
}
