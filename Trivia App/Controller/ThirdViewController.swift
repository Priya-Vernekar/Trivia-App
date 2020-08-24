//
//  ThirdViewController.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit
import SQLite3

class ThirdViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ActionProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var checkMarkOptions : [[String:Any]] = [["name":"White","isSelected":false],["name":"Yellow","isSelected":false],["name":"Orange","isSelected":false],["name":"Green","isSelected":false]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        tableView.register(UINib(nibName: "ActionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionTableViewCell")
        getDatabaseConnection()
        createTable()
    }
    
    func insert(name: String, cricketer: String, flagColors: String, date: String) {
        print("name is ..\(name)")
        print("cricketer is ..\(cricketer)")
        print("flagColors is ..\(flagColors)")
        print("Date is ..\(date)")
        
        let insertStatementString = "INSERT INTO GameInfoTable(Name, BestCricketer, FlagColors, Date) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            sqlite3_bind_text(insertStatement, 1, name, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 2, cricketer, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 3, flagColors, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 4, date, -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        sqlite3_finalize(insertStatement)
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController
        setNavBackTitle(title: "Q3")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func nextAction() {
        let flagColorsDetails = checkMarkOptions.filter { ($0)["isSelected"] as! Bool
        }
        print("flagColorsDetails is ..\(flagColorsDetails)")
        if (flagColorsDetails as [[String:Any]]).isEmpty {
            showAlert(title: "Message", message: "Please Select colors to proceed!")
            return
        }
        var flagColors = ""
        for item in flagColorsDetails {
            if let name = item["name"] as? String {
                flagColors = flagColors + (flagColors.isEmpty ? name : ("," + name))
            }
        }
        GameInfo.sharedGameInfo.flagColors = flagColors
        insert(name: GameInfo.sharedGameInfo.name, cricketer: GameInfo.sharedGameInfo.bestCricketer, flagColors: GameInfo.sharedGameInfo.flagColors, date: getDateString(format: "dd MMM, hh:mm a", date: Date()))
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell
            cell?.titleLabel.text = "What are the colors in the national flag?"
            cell?.selectionStyle = .none
            return cell!
        case 1...4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as? OptionTableViewCell
            cell?.optionLabel.text = checkMarkOptions[indexPath.row-1]["name"] as? String
            cell?.optionBtn.setImage(UIImage(named: (checkMarkOptions[indexPath.row-1]["isSelected"] as! Bool) ? "checkMark" : "uncheck"), for: .normal)
            cell?.selectionStyle = .none
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActionTableViewCell", for: indexPath) as? ActionTableViewCell
            cell?.delegate = self
            cell?.actionBtn.setTitle("NEXT", for: .normal)
            cell?.selectionStyle = .none
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 {
            checkMarkOptions[indexPath.row-1]["isSelected"] = !(checkMarkOptions[indexPath.row-1]["isSelected"] as! Bool)
            tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
        }
    }
    
    
    
    
}

