//
//  SecondViewController.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ActionProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var radioOptions : [[String:Any]] = [["name":"Sachin Tendulkar","isSelected":true],["name":"Virat Kolli","isSelected":false],["name":"Adam Gilchirst","isSelected":false],["name":"Jacques Kallis","isSelected":false]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        tableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        tableView.register(UINib(nibName: "ActionTableViewCell", bundle: nil), forCellReuseIdentifier: "ActionTableViewCell")
    }
    
    func nextAction() {
        let bestCricketer = radioOptions.filter { item in
            (item["isSelected"] as! Bool)
        }
        GameInfo.sharedGameInfo.bestCricketer = bestCricketer[0]["name"] as! String
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController
        setNavBackTitle(title: "Q2")
        self.navigationController?.pushViewController(vc!, animated: true)
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
            cell?.titleLabel.text = "Who is the best cricketer in the world?"
            cell?.selectionStyle = .none
            return cell!
        case 1...4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as? OptionTableViewCell
            cell?.optionLabel.text = radioOptions[indexPath.row-1]["name"] as? String
            cell?.optionBtn.setImage(UIImage(named: (radioOptions[indexPath.row-1]["isSelected"] as! Bool) ? "checked" : "unchecked"), for: .normal)
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
            radioOptions[indexPath.row-1]["isSelected"] = !(radioOptions[indexPath.row-1]["isSelected"] as! Bool)
            for (index,_) in radioOptions.enumerated() {
                if index != indexPath.row-1 {
                    radioOptions[index]["isSelected"] = !(radioOptions[indexPath.row-1]["isSelected"] as! Bool)
                }
            }
            tableView.reloadRows(at: [IndexPath(row: 1, section: 0),IndexPath(row: 2, section: 0),IndexPath(row: 3, section: 0),IndexPath(row: 4, section: 0)], with: .none)
        }
    }
    
    
    
}
