//
//  ViewController.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/12.
//

import UIKit
import Foundation
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!

   
   
   
    let jsonUrl = URL(string: "https://script.google.com/macros/s/AKfycbwJqiqlCU2PwK_sGxgwRzaCmJDrv58RrE2knlSWQtwAJ0J_pE-fBTR7ppnx4TuHXfl-/exec")
    func getJsonDataFromGoogleAppsScript(completion: @escaping ([Products]?) -> Void) {
        var request = URLRequest(url: jsonUrl!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            guard let data = data else { return }
           
            let decoded = try? JSONDecoder().decode([Products].self, from: data)
         
        }.resume()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getJsonDataFromGoogleAppsScript(completion: {
      
            print($0)
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return dat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
//        cell.textLabel?.text = [dat.count].age)
//        cell.detailTextLabel?.text = products[dat.count].name
        
        return cell
    }

}
