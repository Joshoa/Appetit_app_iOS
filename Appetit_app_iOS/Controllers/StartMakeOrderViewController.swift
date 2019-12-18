//
//  StartMakeOrderViewController.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 17/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit

class StartMakeOrderViewController: UIViewController {
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    public func initViews() {
        self.title = "Informações para o pedido"
        configProgressView()
    }
    
    private func configProgressView() {
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
    }
}
