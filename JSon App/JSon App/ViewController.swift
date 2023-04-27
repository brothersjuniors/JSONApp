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
    
    @IBOutlet weak var table: UITableView!
  
    
    var decode:[Products] = []
    let jsonUrl = URL(string: "https://script.google.com/macros/s/AKfycbwJqiqlCU2PwK_sGxgwRzaCmJDrv58RrE2knlSWQtwAJ0J_pE-fBTR7ppnx4TuHXfl-/exec")
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
        getJsonDataFromGoogleAppsScript()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return decode.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        
        cell.textLabel?.text = decode[indexPath.row].name
        cell.detailTextLabel?.text = String(decode[indexPath.row].age)
        return cell
    }
    
}


