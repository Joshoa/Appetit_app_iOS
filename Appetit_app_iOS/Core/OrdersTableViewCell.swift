//
//  OrdersTableViewCell.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 17/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbClient: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbProducts: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func prepare(with order: Order) {
        lbClient.text = order.client
        lbPrice.text = String(format: "R$ %.02f", order.amount)
        lbProducts.text = order.products
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
