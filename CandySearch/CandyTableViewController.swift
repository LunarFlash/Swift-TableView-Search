//
//  CandyTableViewController.swift
//  CandySearch
//
//  Created by Yi Wang on 8/24/14.
//  Copyright (c) 2014 Yi. All rights reserved.
//

import UIKit

class CandyTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    // array of candies
    var candies = [Candy]()
    // filtered search results
    var filteredCandies = [Candy]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Sample Data for candyArray
        self.candies = [Candy(category:"Chocolate", name:"chocolate Bar"),
            Candy(category:"Chocolate", name:"chocolate Chip"),
            Candy(category:"Chocolate", name:"dark chocolate"),
            Candy(category:"Hard", name:"lollipop"),
            Candy(category:"Hard", name:"candy cane"),
            Candy(category:"Hard", name:"jaw breaker"),
            Candy(category:"Other", name:"caramel"),
            Candy(category:"Other", name:"sour chew"),
            Candy(category:"Other", name:"gummi bear")]
        
        // Reload the table
        self.tableView.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if tableView == self.searchDisplayController.searchResultsTableView {
            return self.filteredCandies.count
        } else {
            return self.candies.count
        }
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
       
        var candy : Candy
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = self.candies[indexPath.row]
        }
        
        // Configure cell
        cell.textLabel.text = candy.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
          self.performSegueWithIdentifier("candyDetail", sender: tableView)
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "candyDetail" {
            let candyDetailViewController = segue.destinationViewController as UIViewController
            if sender as UITableView == self.searchDisplayController.searchResultsTableView {
                let indexPath = self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow()
                let destinationTitle = self.filteredCandies[indexPath.row].name
                candyDetailViewController.title = destinationTitle
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()
                let destinationTitle = self.candies[indexPath.row].name
                candyDetailViewController.title = destinationTitle
            }
        }
    }


   
    
    // closure syntax {(parameters) -> (return type) in expression statements}
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredCandies = self.candies.filter({( candy : Candy) -> Bool in
            var categoryMatch = (scope == "All") || (candy.category == scope)
            var stringMatch = candy.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        let scopes = self.searchDisplayController.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchText(searchString, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        let scope = self.searchDisplayController.searchBar.scopeButtonTitles as [String]
        self.filterContentForSearchText(self.searchDisplayController.searchBar.text, scope: scope[searchOption])
        return true
    }
    
    
    
    
    
    
    
    
    
}
