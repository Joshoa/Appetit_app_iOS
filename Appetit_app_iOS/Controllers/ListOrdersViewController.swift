//
//  ListOrdersViewController.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 16/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit

class ListOrdersViewController: UIViewController {
    
    @IBOutlet weak var btNewOrder: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var user: User?

    // MARK: - Controllers functions
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrders()
        initViews()
    }
    
    // MARK: - Data load functions
    private func loadOrders() {
        
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
