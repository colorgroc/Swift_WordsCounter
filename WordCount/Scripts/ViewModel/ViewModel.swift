//
//  ViewModel.swift
//  WordCount
//
//  Created by Anna Ponce on 08/05/2021.
//

import Foundation

class ViewModel {
  
  //MARK: Variables
  var sortedBy = SortedType.byPosition
  
  private var wordsInitialList = [WordsList]()
  
  //MARK: Initial Functions
  private func getWords(text: String?) -> Dictionary<String, Int>{
    var wordsDictionary = Dictionary<String, Int>()
    
    guard let text = text else { return wordsDictionary }
    
    let wordsArray = text.components(separatedBy: CharacterSet.whitespacesAndNewlines.union(NSCharacterSet(charactersIn: ".,:;-`_?!¡¿()\"][*$") as CharacterSet).union(CharacterSet.decimalDigits))
    
    for word in wordsArray{
      var capitalizedWord = word.capitalized
      if capitalizedWord.first == "'"{
        capitalizedWord = capitalizedWord.replacingOccurrences(of: "'", with: "")
      }

      if let appearanceNum = wordsDictionary[capitalizedWord]{
        wordsDictionary[capitalizedWord] = appearanceNum + 1
      } else{
        if capitalizedWord != "" && capitalizedWord != "'" && capitalizedWord != "\u{1a}" && capitalizedWord != "\u{1a}\u{1a}"{

          wordsDictionary[capitalizedWord] = 1
        }
      }
    }
    return wordsDictionary
  }
  
  private func getInitialWordsList(text: String?) -> [WordsList]{
    var wordsList = [WordsList]()
    for word in getWords(text: text){
      wordsList.append(WordsList(word: word.key, count: word.value))
      
    }
    return wordsList
  }
  
  //MARK: Load Text Function
  func loadText(fileName: String){
    let pathFile = Bundle.main.path(forResource: fileName, ofType: "txt")
    
    guard let path = pathFile else{ return }
    if let text = try? String(contentsOfFile: path, encoding: .utf8){
      wordsInitialList = getInitialWordsList(text: text)
    } else{
      print(fileName + " file couldn't be found.")
      return
    }
  }
}






