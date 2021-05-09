//
//  HeaderView.swift
//  WordCount
//
//  Created by Anna Ponce on 09/05/2021.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
  
  @IBOutlet weak var totalTitleLbl: UILabel!
  @IBOutlet weak var totalValueLbl: UILabel!
  @IBOutlet weak var view: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    totalTitleLbl.text = "Total Words:"
    view.layer.cornerRadius = 4
    view.backgroundColor = #colorLiteral(red: 0.937140882, green: 0.9372404218, blue: 0.9412251115, alpha: 1)
  }
  
  func setHeader(total: Int){
    self.totalValueLbl.text = String(total)
  }
}
