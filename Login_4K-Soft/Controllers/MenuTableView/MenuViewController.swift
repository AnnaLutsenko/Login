//
//  MenuTableViewController.swift
//  Login_4K-Soft
//
//  Created by Anna on 12.12.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuDelegate: ContainerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViewController()
    }
    
    func initViewController() {
        navigationController?.navigationBar.barTintColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }

    
    @IBAction func openMenu(_ sender: Any) {
        self.menuDelegate.menuBtnTapped()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdentifier.menu, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
