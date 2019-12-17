//
//  ListOrdersViewController.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 16/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit
import CoreData

class ListOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btNewOrder: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var user: User?
    private var fetchedResultController: NSFetchedResultsController<Order>!
    private var lbNoOrders = UILabel()

    // MARK: - Controllers functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configLbNoOrders()
        loadOrders()
        initViews()
    }
    
    // MARK: - Data load functions
    private func loadOrders() {
        importDataFromServer()
    }
    
    private func importDataFromServer() {
        let parameters = ["user": "\(user?.id ?? 0)" ]
        RestfulWebService.importOrdersWS(context: context, parameters: parameters, callback: {})
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resultController = fetchedResultController, let count = resultController.fetchedObjects?.count, count > 0 {
            tableView.backgroundView = nil
            return count
        } else {
            tableView.backgroundView = lbNoOrders
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    // MARK: - Views configure functions
    public func setUser(_ user: User) {
        self.user = user
    }
    
    private func initViews() {
        if user != nil {
            self.title = "Olá, \(user!.name ?? "No name")!"
        }
        configSearchBar()
    }
    
    private func configLbNoOrders() {
        lbNoOrders.text = Strings.noOrdersLabelText.uppercased()
        lbNoOrders.textColor = UIColor(named: "dark_color")
        lbNoOrders.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lbNoOrders.textAlignment = .center
    }
    
    private func configSearchBar() {
        UIUtils.changeUISearchBarColor(searchBar: searchBar, color: UIColor(named: "main_color")!)
        UIUtils.changeUISearchFont(searchBar: searchBar, size: 18)
        searchBar.tintColor = UIColor(named: "main_color")
    }
    
    // MARK: - Actions functions
    @IBAction func newOrderAction(_ sender: UIButton) {
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
    }
}
