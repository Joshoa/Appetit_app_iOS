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
    private var listIsAscending: Bool = true
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
        fetchOrders()
    }
    
    private func setAndApplyFilters() {
        listIsAscending = !listIsAscending
        fetchedResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "amount", ascending: listIsAscending)]
        GenericDao.performFetch(fetchedResultController: fetchedResultController as! NSFetchedResultsController<NSFetchRequestResult>)
        tableView.reloadData()
    }
    
    private func importDataFromServer() {
        OrderDao.deleteAll(with: context)
        let parameters = ["user": "\(user?.id ?? 0)" ]
        RestfulWebService.importOrdersWS(context: context, parameters: parameters, callback: {})
    }
    
    private func fetchOrders(ascending: Bool = true) {
        fetchedResultController = NSFetchedResultsController(fetchRequest: OrderDao.getFetchRequest(ascending: ascending), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        GenericDao.performFetch(fetchedResultController: fetchedResultController as! NSFetchedResultsController<NSFetchRequestResult>)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.orderCell, for: indexPath) as! OrdersTableViewCell
        guard let order = fetchedResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        // Configure the cell...
        cell.prepare(with: order)
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
        configTableView()
        configSearchBar()
    }
    
    private func configTableView() {
        self.tableView.register(UINib(nibName: Strings.ordersTableViewCellXib, bundle: nil), forCellReuseIdentifier: Strings.orderCell)
        self.tableView.rowHeight = UITableView.automaticDimension
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
        setAndApplyFilters()
    }
}


extension ListOrdersViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                break
            default:
                tableView.reloadData()
        }
    }
}
