//
//  ViewController.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/12.
//

import UIKit
import Foundation
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var products = [Products]()
    private  var searching = false
    private var searchedItem = [Products]()
    @IBOutlet weak var table: UITableView!
  //  private var data: Products!
    
    var decode:[Products] = []
    let jsonUrl = URL(string: "https://script.google.com/macros/s/AKfycbzyV2oKUU8tZEncsZNJ3K7TRtAjessILPugmH8toUBIF65RWfUkYUKQvCC5SqvpcAS9/exec")
    func getJsonDataFromGoogleAppsScript()-> Void {
        var request = URLRequest(url: jsonUrl!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            guard let data = data else { return }
            decode = try! JSONDecoder().decode([Products].self, from: data)
            DispatchQueue.main.async { [self] in
                self.products = products
                self.table.reloadData()
                
                
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        getJsonDataFromGoogleAppsScript()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return decode.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ListTableViewCell
        
        
        cell.makerLabel?.text = decode[indexPath.row].maker
        cell.itemLabel?.text = String(decode[indexPath.row].name)
        cell.janLabel?.text = String(decode[indexPath.row].jan)
        cell.caoaLabel?.text = String(decode[indexPath.row].capa)
        
        return cell
    }
    
}
extension ViewController: UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedItem.removeAll()
            for i in decode {
                if i.name.lowercased().contains(searchText.lowercased()) {
                    searchedItem.append(i)
                }
            }
            table.reloadData()
        } else {
            searching = false
            searchedItem.removeAll()
        }
        table.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedItem.removeAll()
        table.reloadData()
    }
}


