//
//  SortedViewController.swift
//  WordCount
//
//  Created by Anna Ponce on 08/05/2021.
//

import Foundation
import UIKit

class SortedViewController: UIViewController {
  @IBOutlet weak var sortedLbl: UILabel!
  @IBOutlet weak var byPosition: UIButton!
  @IBOutlet weak var byAlphabet: UIButton!
  @IBOutlet weak var byAppearances: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var stackView: UIStackView!
  
  let wordCell = "WordCell"
  
  var wordsList = [WordsList](){
    didSet{
      if let model = model{
        tableView.reloadData()
      }
    }
  }
  
  var searchController = UISearchController(searchResultsController: nil)
  var navTitle: String?
  
  var model: ViewModel?
  
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  
  //MARK: Initial Set Up
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setDelegates()
    registerXib()
  }
  
  private func setDelegates(){
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  private func configureUI(){
        
    setButtons()
    self.navigationItem.backBarButtonItem?.action = #selector(goBack)
    
    self.tableView.tableFooterView = UIView(frame: .zero)
    
  }
  
  private func registerXib(){
    let nibCell = UINib(nibName: wordCell, bundle: Bundle.main)
    tableView.register(nibCell, forCellReuseIdentifier: wordCell)
  }
  
  private func setButtons(){
    
    sortedLbl.text = "sorted by:"
    sortedLbl.font =  UIFont(name: "Helvetica", size: 10)
    
    byPosition.setButton(name: SortedType.byPosition.name, size: 15)
    byAlphabet.setButton(name: SortedType.byAlphabet.name, size: 15)
    byAppearances.setButton(name: SortedType.byAppearances.name, size: 15)
    
  }
  
  
  //MARK: IBActions
  @objc private func goBack(){
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func sortByPosition(_ sender: Any) {
    if let model = model{
      byPosition.selectButton(stackview: self.stackView, initialFontSize: 15)
      model.sortedBy = .byPosition
    }
  }
  
  @IBAction func sortByAlphabet(_ sender: Any) {
    if let model = model{
      byAlphabet.selectButton(stackview: self.stackView, initialFontSize: 15)
      model.sortedBy = .byAlphabet
    }
  }
  
  @IBAction func sortByAppearances(_ sender: Any) {
    if let model = model{
      byAppearances.selectButton(stackview: self.stackView, initialFontSize: 15)
      model.sortedBy = .byAppearances
    }
  }
}

//MARK: TableView Delegates
extension SortedViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wordsList.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: wordCell, for: indexPath) as? WordCell{
      
      cell.setCell(word: wordsList[indexPath.row].word , counter: wordsList[indexPath.row].count)
      return cell
    }
    return UITableViewCell()
  }

}

