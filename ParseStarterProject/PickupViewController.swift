//
//  PickupViewController.swift
//  Money2020
//
//  Created by Suchit Panjiyar on 10/24/15.
//  Copyright © 2015 Hack. All rights reserved.
//

import UIKit
import Parse

class PickupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CurrentOrderTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        runQuery()
        // Do any additional setup after loading the view.
    }
    
    var itemsToBePickedUp = ["aa","lp"]

    var OrderNumber: [Int] = []
    var quantity: [Int] = []
    var name: [String] = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderNumber.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CurrentOrderTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as! CurrentOrderTableViewCell
        cell.name.text = name[indexPath.row]
        cell.quantity.text = String(quantity[indexPath.row])
        cell.orderNumber.text = String(OrderNumber[indexPath.row])
        return cell
    }
    
    func runQuery()
    {
        var query = PFQuery(className: "VendorDatabase")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil
            {
                if objects == nil
                {
                    print("Bhenchod")
                }
                else
                {
                    print ("bc")
                    for eachObject in objects!
                    {
                        if (eachObject["IDNumber"] as! Int) == 2
                        {
                            self.OrderNumber.append(eachObject["OrderNumber"] as! Int)
                            self.quantity.append(eachObject["Quantity"] as! Int)
                            self.name.append(eachObject["Name"] as! String)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
}
