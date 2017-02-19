//
//  DataViewController.swift
//  new_redy4s
//
//  Created by Bartek Lanczyk on 12.12.2016.
//  Copyright © 2016 miltenkot. All rights reserved.
//

import UIKit

class DataViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
   

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var urlsTable:[URL_Entity] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            revealViewController().rearViewRevealOverdraw = 0
            //table view
            tableView.dataSource = self
            tableView.delegate = self
            
             
           
            
            // Do any additional setup after loading the view.
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //get the data from core data
        getData()
        //reload the table view
        tableView.reloadData()
    }
    //MARK: Table view configuration

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlsTable.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DataCell"
       guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DataTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of DataTableViewCell.")
        }
        
        let url_entity = urlsTable[indexPath.row]
        
        cell.urlDataLabel.text = url_entity.orginal_url!
        cell.shortUrlDataLabel.text = url_entity.short_url!
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let url_entity = urlsTable[indexPath.row]
            context.delete(url_entity)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                
                urlsTable = try context.fetch(URL_Entity.fetchRequest())
            }
            catch{
                print("Fetching Field")
            }
        }
        tableView.reloadData()
    }

    func getData(){
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            
            urlsTable = try context.fetch(URL_Entity.fetchRequest())
        }
        catch{
            print("Fetching Field")
        }
    }


}
