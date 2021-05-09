//
//  ExtraInfo.swift
//  WordCount
//
//  Created by Anna Ponce on 09/05/2021.
//

import UIKit

//MARK: Color
class ExtraInfo{
  static let mainColor = #colorLiteral(red: 0, green: 0.631372549, blue: 1, alpha: 1)
}

//MARK: SortedType Enum
enum SortedType{
  case byPosition
  case byAlphabet
  case byAppearances
  
  var name: String{
    switch self {
    case .byPosition:
      return "Position"
    case .byAlphabet:
      return "Alphabetically"
    case .byAppearances:
      return "Appearances"
    }
  }
}

//MARK: WordsList Class
class WordsList{
  var word: String
  var count: Int
  var position: Int
  
  init(word: String, count: Int, position: Int) {
    self.word = word
    self.count = count
    self.position = position
  }
}

// MARK: Button Extension
extension UIButton{
  func setButton(name: String, size: CGFloat = 20, border: Bool = false){
    self.setTitle(name, for: .normal)
    
    self.setTitleColor(ExtraInfo.mainColor, for: .normal)
    self.setTitleColor(ExtraInfo.mainColor, for: .selected)
    self.setTitleColor(.gray, for: .focused)
    
    self.titleLabel?.font = UIFont(name: "Helvetica", size: size)
    self.titleLabel?.textAlignment = .center
    self.titleLabel?.lineBreakMode = .byWordWrapping
    
    if border{
      self.layer.borderWidth = 1
      self.layer.borderColor = ExtraInfo.mainColor.cgColor
      self.layer.cornerRadius = 10
    }
    
    self.backgroundColor = .clear
  }
  
  func selectButton(stackview: UIStackView, initialFontSize: CGFloat){
    for subview in stackview.subviews{
      if subview.isKind(of: UIButton.self){
        if let button = subview as? UIButton{
          button.titleLabel?.font = UIFont(name:"Helvetica", size: initialFontSize)
        }
      }
    }
    self.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: initialFontSize + 2)
  }
}
