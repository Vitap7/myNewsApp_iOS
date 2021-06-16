//
//  SearchResultTableViewController.swift
//  myNews
//
//  Created by 777 on 2021/6/7.
//

import UIKit

class SearchResultTableViewController: UITableViewController, UISearchResultsUpdating {
        
    var allNews:[News] = []
    var filterNews:[News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MasterCell")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else {return}
        
        if searchString.isEmpty {return}
        
        filterNews = allNews.filter {$0.title.contains(searchString)}
            
        tableView.reloadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterNews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)

        cell.textLabel?.text = filterNews[indexPath.row].title
        
        cell.detailTextLabel?.text = filterNews[indexPath.row].passtime
        
        let img = cell.imageView
        img?.downloadAsyncFrom(url: filterNews[indexPath.row].image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = mainstoryboard.instantiateViewController(withIdentifier: "detailVC") as! ViewController
        let nav = self.presentingViewController
        detailVC.news = filterNews[tableView.indexPathForSelectedRow!.row]
        detailVC.isStar = false
        nav?.present(detailVC, animated: true, completion: nil)
    }

}
