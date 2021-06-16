//
//  StarTableViewController.swift
//  myNews
//
//  Created by 777 on 2021/6/7.
//

import UIKit

class StarTableViewController: UITableViewController {
    
    var recordNews = sqlClass.loadNews()

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sqlClass.initDB()
        
        tabBarItem.badgeValue = "\(recordNews!.count)"
        
        initSearch()
    }

    // MARK: Search
    func initSearch()
    {
        let resultsController = SearchResultTableViewController()
    
        resultsController.allNews = recordNews!

        searchController = UISearchController(searchResultsController: resultsController)
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["标题"]
        searchBar.placeholder = "Enter a search item"
        searchBar.sizeToFit()
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        self.definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sqlClass.loadNews()!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)
        
        let news = sqlClass.loadNews()![indexPath.row]
        
        cell.textLabel?.text = news.title
        
        cell.detailTextLabel?.text = news.passtime
        
        let img = cell.imageView
        img?.downloadAsyncFrom(url: news.image)

        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            sqlClass.deleteNews(news: sqlClass.loadNews()![indexPath.row])
            recordNews = sqlClass.loadNews()
            recordNews!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tabBarItem.badgeValue = "\(sqlClass.loadNews()!.count)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let ViewController = segue.destination as? ViewController else {return}

        if let indexPath = tableView.indexPathForSelectedRow
        {
            ViewController.news = sqlClass.loadNews()![indexPath.row]
            ViewController.isStar = false
        }
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue) {
        
        guard let ViewController = segue.source as? ViewController else {return}
        
        if ViewController.isStar
        {
            sqlClass.addNews(news: ViewController.news!)
            tabBarItem.badgeValue = "\(sqlClass.loadNews()!.count)"
        }
    }
}
