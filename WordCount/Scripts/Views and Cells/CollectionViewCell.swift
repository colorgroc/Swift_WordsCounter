//
//  CollectionViewCell.swift
//  WordCount
//
//  Created by Anna Ponce on 09/05/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{
  
  @IBOutlet weak var cellLbl: UILabel!
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }
  
  public override var isSelected: Bool{
    didSet{
      if isSelected{
        selectCell()
      } else{
        deselectCell()
      }
    }
  }
  
  func selectCell(){
    cellLbl.font = .boldSystemFont(ofSize: 20)
    cellLbl.textColor = ExtraInfo.mainColor
  }
  func deselectCell(){
    cellLbl.font = .systemFont(ofSize: 15)
    cellLbl.textColor = .black
  }
}
