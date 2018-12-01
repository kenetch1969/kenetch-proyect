//
//  CountryTableViewController.swift
//  mvp
//
//  Created by Juan Gerardo Cruz on 11/27/18.
//  Copyright © 2018 Juan Gerardo Cruz. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {

    private var list = [Country]()
    var presenter = TablePresenter(serviceCountry: Services())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attachView(view: self)
        presenter.getContriesList(with: "all")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        let country = list[indexPath.row]
        // Configure the cell...
        cell.imageView?.image = UIImage(named: "telecope")
        cell.textLabel?.text = country.alpha3Code
        cell.detailTextLabel?.text = country.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detalles", sender: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detalles" {
            if let detalles = segue.destination as? ViewController{
                if let indexPath = tableView.indexPathForSelectedRow {
                    detalles.setCountry(country: list[indexPath.row])
                }
            }
        }
    }
 

}

extension CountryTableViewController: TableView {
    
    func startLoading() {
//        viewProgress.startAnimating()
//        viewProgress.isHidden = false
    }
    
    func stopLoading() {
//        viewProgress.stopAnimating()
//        viewProgress.isHidden = true
    }
    
    //Devuelve la informacion de la lista y recarga la tableview
    func showData(list: [Country]) {
        self.list = list
//        let task = {
//            self.tableView.reloadData()
//        }
//        let operationQueue = OperationQueue.main
//        operationQueue.qualityOfService = .default
//        operationQueue.addOperation(task)
//        OperationQueue.main.addOperation({
//            self.tableView.reloadData()
//        })
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func  showMessage ( mensaje : String ){
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Alert", message: mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
       }
    }
}
