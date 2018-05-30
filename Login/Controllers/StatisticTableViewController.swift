//
//  StatisticTableViewController.swift
//  Login
//
//  Created by Anna on 28.05.2018.
//  Copyright © 2018 Anna Lutsenko. All rights reserved.
//

import UIKit

class StatisticTableViewController: UITableViewController, StoryboardInstance {
    
    /// Managers
    var dataProvider: AuthorizatorProtocol & DataProviderProtocol = NetworkDataProvider.shared
    
    /// Models
    var text: TextModel?
    var dict: [Character: Int] = [:]
    var keys: [Character] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getText()
    }
    
    func storyboardInstance() {
        
    }
    
    func getText() {
        dataProvider.getText(success: { (txt) in
            print(txt)
            self.reloadTable(txt)
        }) { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    func reloadTable(_ txt: String) {
        text = TextModel(text: txt)
        guard let dic = self.text?.getCharCount() else { return }
        dict = dic
        for key in dict.keys {
            keys.append(key)
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        //
        let key = keys[indexPath.row]
        cell.textLabel?.text = String(key)
        cell.detailTextLabel?.text = String(dict[key] ?? 0)
        //
        return cell
    }
}
