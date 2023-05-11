//
//  ViewController.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/12.
//

import UIKit
import Foundation
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    private var janString: String?
    private var products = [Products]()
    private  var searching = false
    private var searchedItem = [Products]()
    @IBOutlet weak var table: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var decode:[Products] = []
    private let jsonUrl = URL(string: "https://script.google.com/macros/s/AKfycbwcMVnhpumQUla-48TRbUFLgcad3Q7OuvU5Rj0ctZ3LG_A0UBVnC-mJ_km6Oz4XBbYa/exec")
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
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        getJsonDataFromGoogleAppsScript()
        DispatchQueue.main.async { [self] in
            _ =  BarcodeGenerator.generateBarCode(from: "\(janString ?? "4902011713725")")!
            configulation()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedItem.count
        } else {
            return decode.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  self.performSegue(withIdentifier: "detail", sender: self)
        guard let vc = storyboard?.instantiateViewController(identifier: "detail") as? NextViewController else { return }
        if let indexPath = table.indexPathForSelectedRow {
            var item: Products
            if searching {
                item  = searchedItem[indexPath.row]
            } else {
                item = decode[indexPath.row]
            }
            vc.item = item
        }
        // vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        table.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var item: Products
        if searching {
            item = searchedItem[indexPath.row]
            janString = String(searchedItem[indexPath.row].jan)
        } else {
            item = decode[indexPath.row]
            janString = String(item.jan)
            
        }
        let image =  BarcodeGenerator.generateBarCode(from: "\(janString ?? "4902011713725")")!
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ListTableViewCell
        cell.makerLabel?.text = item.maker
        cell.itemLabel?.text = String(item.name)
        cell.janLabel?.text = String(item.jan)
        cell.caoaLabel?.text = String(item.capa)
        
        return cell
    }
    //SearchBarで検索機能付加
    private func configulation(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "検索したい商品名を入力してください"
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


