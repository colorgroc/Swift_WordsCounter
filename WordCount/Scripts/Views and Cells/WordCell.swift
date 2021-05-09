//
//  WordCell.swift
//  WordCount
//
//  Created by Anna Ponce on 08/05/2021.
//

import UIKit

class WordCell: UITableViewCell {
  @IBOutlet weak var wordLbl: UILabel!
  @IBOutlet weak var counterLbl: UILabel!
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setCell(word: String, counter: Int){
    self.wordLbl.text = word
    self.counterLbl.text = String(counter)
  }
}
