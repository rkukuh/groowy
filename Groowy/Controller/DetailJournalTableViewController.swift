//
//  DetailJournalTableViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/15/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class DetailJournalTableViewController: UITableViewController, SectionHeaderTableViewCellDelegate {
    func toggleSection(header: SectionHeaderTableViewCell, section: Int) {
        print("yayyyy")
        isHidden[section] = !isHidden[section]
        tableView.reloadSections(IndexSet(section...section), with: .automatic)
    }
    
    var isHidden :[Bool] = [false,false]
    var chalange : Challenge?
    let formatter = DateFormatter()
    @IBOutlet weak var evidenceImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var learnReflectionLabel: UILabel!
    @IBOutlet weak var feelLabel: UILabel!
    @IBOutlet weak var learnDetailLabel: UILabel!
    @IBOutlet weak var activitiesLearnLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        learnDetailLabel.text = chalange?.title
        activitiesLearnLabel.text = chalange?.body
        goalLabel.text = chalange?.goal
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if chalange?.remind_at != nil {
            let myString = String(format: "%@", chalange!.remind_at!)
            timeLabel.text = myString
        }else{
            timeLabel.text = ""
        }
        
        questionLabel.text = ""
        learnReflectionLabel.text = ""
        feelLabel.text = ""
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isHidden[section] == false {
            return 1
        }else{
            return 0
        }
        
    }
    
   
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = SectionHeaderTableViewCell(view: self.view)
        cell.section = section
        
        if isHidden[section] {
            cell.arrowLabel?.text = "▶︎"
        }else{
            cell.arrowLabel?.text = "▼"
        }
        
        if section == 0 {
            cell.titleLabel?.text = "Detail"
        }else{
            cell.titleLabel?.text = "Reflection"
        }
        
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print("Hello")
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.sectionHeaderWasTouched(_:)))
        
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
    }

    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        print("sapo")
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        print(section)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
