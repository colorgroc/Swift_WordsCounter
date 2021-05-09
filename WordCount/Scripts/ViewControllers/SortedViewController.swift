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
  
  var searchController = UISearchController(searchResultsController: nil)
  var navTitle: String?
  
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
  
  private func setButtons(){
    
    sortedLbl.text = "sorted by:"
    sortedLbl.font =  UIFont(name: "Helvetica", size: 10)
    
    byPosition.setButton(name: "Posicion", size: 15)
    byAlphabet.setButton(name: "Aphabetically", size: 15)
    byAppearances.setButton(name: "Appearances", size: 15)
    
  }
  
  
  //MARK: IBActions
  @objc private func goBack(){
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func sortByPosition(_ sender: Any) {
    print("Position")
  }
  
  @IBAction func sortByAlphabet(_ sender: Any) {
    print("Alphabet")
  }
  
  @IBAction func sortByAppearances(_ sender: Any) {
    print("Appeared")
  }
}

//MARK: TableView Delegates
extension SortedViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }

}

