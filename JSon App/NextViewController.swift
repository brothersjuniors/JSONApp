//
//  NextViewController.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/29.
//

import UIKit

class NextViewController: UIViewController {
    var item: Products!
    private var janString: String?
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var capaLabel: UILabel!
    @IBOutlet weak var janLabel: UILabel!
    @IBOutlet weak var janImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makerLabel.text = item?.maker
        janString = String(item.jan)
        janLabel.text = String(item.jan)
        itemLabel.text = item?.name
        capaLabel.text = String(item.capa)
        DispatchQueue.main.async { [self] in
            
            let image =  BarcodeGenerator.generateBarCode(from: "\(janString ?? "4902011713725")")!
            janImage.image = image
            
        }
        
    }
    }
