//
//  SummaryViewController.swift
//  Trivia App
//
//  Created by Priya Vernekar on 24/08/20.
//  Copyright © 2020 Priya Vernekar. All rights reserved.
//

import UIKit
import SQLite3

class SummaryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
    }
    
    @IBAction func finishBtnAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func historyBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController
        setNavBackTitle(title: "Summary")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                return createCell(tableView, cellForRowAt: indexPath, title: "Hello " + GameInfo.sharedGameInfo.name + ",", value: "Here are the answers selected:")
            case 1:
                return createCell(tableView, cellForRowAt: indexPath, title: "Who is the best cricketer in the world?", value: GameInfo.sharedGameInfo.bestCricketer)
            case 2:
                return createCell(tableView, cellForRowAt: indexPath, title: "What are the colors in the national flag?", value: GameInfo.sharedGameInfo.flagColors)
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "summaryActionCell", for: indexPath)
                cell.selectionStyle = .none
                return cell
        }
    }
    
    func createCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, title: String, value: String) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as? SummaryTableViewCell
        cell?.titleLabel.text = title
        cell?.valueLabel.text = value
        cell?.selectionStyle = .none
        return cell!
    }
    
}
