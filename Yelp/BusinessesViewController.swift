//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var businessView: UITableView!
    
    var businesses: [Business]!
    
    var filteredBusinesses: [Business]!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil);
        searchController.searchResultsUpdater = self;
        
        //Don't dim out the view because this will be the same view displaying the results
        searchController.dimsBackgroundDuringPresentation = false;
        
        searchController.searchBar.sizeToFit();
        navigationItem.titleView = searchController.searchBar;
        searchController.hidesNavigationBarDuringPresentation = false;
        definesPresentationContext = true
        
        businessView.separatorStyle = .none
        businessView.estimatedRowHeight = 100;
        businessView.rowHeight = UITableViewAutomaticDimension;
        
        businessView.delegate = self;
        businessView.dataSource = self;
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.businessView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter({ (businessData: Business) -> Bool in
                return businessData.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil;
            })
            
            businessView.reloadData();
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredBusinesses?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = businessView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell;
        
        cell.Business = filteredBusinesses[indexPath.row];
        
        return cell;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
