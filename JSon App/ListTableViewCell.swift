//
//  ListTableViewCell.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/28.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var janLabel: UILabel!
    @IBOutlet weak var caoaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   }
override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
