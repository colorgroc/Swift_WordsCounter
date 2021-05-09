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

  @IBOutlet weak var collectionView: UICollectionView!
  
  let wordCell = "WordCell"
  let headerView = "HeaderView"
  
  let pickerData = ["All", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

  var wordsList = [WordsList](){
    didSet{
      if let model = model{
        filterWordsByAlphabet(pickerData[model.collectionViewCellSelected])
        tableView.reloadData()
      }
    }
  }
  
  var filteredWords: [WordsList] = []
  var filteredWordsByAlphabet: [WordsList] = []
  
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
      
    switch model?.sortedBy {
    case .byPosition, .none:
      wordsList = model?.getWordsSortedByPosition() ?? [WordsList]()
      byPosition.selectButton(stackview: self.stackView, initialFontSize: 15)
    case .byAlphabet:
      wordsList = model?.getWordsSortedByAlphabet() ?? [WordsList]()
      byAlphabet.selectButton(stackview: self.stackView, initialFontSize: 15)
    case .byAppearances:
      wordsList = model?.getWordsSortedByAppearances() ?? [WordsList]()
      byAppearances.selectButton(stackview: self.stackView, initialFontSize: 15)
    }
    setCollectionView()
  }
  
  private func setDelegates(){
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  private func registerXib(){
    let nibCell = UINib(nibName: wordCell, bundle: Bundle.main)
    tableView.register(nibCell, forCellReuseIdentifier: wordCell)
    
    let nibHeader = UINib(nibName: headerView, bundle: Bundle.main)
    tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: headerView)
    
    let nib = UINib(nibName: "CollectionViewCell", bundle: Bundle.main)
    collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
  }
  
  private func configureUI(){
        
    setButtons()
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search word"
    searchController.searchResultsUpdater = self
    self.navigationItem.searchController = searchController
    self.definesPresentationContext = true
    
    self.navigationItem.backBarButtonItem?.action = #selector(goBack)
    
    self.tableView.tableFooterView = UIView(frame: .zero)
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
      wordsList = model.getWordsSortedByPosition()
    }
  }
  
  @IBAction func sortByAlphabet(_ sender: Any) {
    if let model = model{
      byAlphabet.selectButton(stackview: self.stackView, initialFontSize: 15)
      model.sortedBy = .byAlphabet
      wordsList = model.getWordsSortedByAlphabet()
    }
  }
  
  @IBAction func sortByAppearances(_ sender: Any) {
    if let model = model{
      byAppearances.selectButton(stackview: self.stackView, initialFontSize: 15)
      model.sortedBy = .byAppearances
      wordsList = model.getWordsSortedByAppearances()
    }
  }
}

//MARK: SearchBar Delegate
extension SortedViewController: UISearchResultsUpdating{
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else { return }
    filterWords(text)
  }
  
  func filterWords(_ searchText: String){
    //sensitive case
    filteredWords = filteredWordsByAlphabet.filter({ $0.word.contains(searchText)})
    tableView.reloadData()
  }
  
}

//MARK: TableView Delegates
extension SortedViewController: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering{
      return filteredWords.count
    }
    return filteredWordsByAlphabet.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: wordCell, for: indexPath) as? WordCell{
      var list = [WordsList]()
      
      if isFiltering{ list = filteredWords }
      else{ list = filteredWordsByAlphabet }
      
      cell.setCell(word: list[indexPath.row].word , counter: list[indexPath.row].count)
      return cell
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerView) as? HeaderView{
      var list = [WordsList]()
      if isFiltering{ list = filteredWords }
      else{ list = filteredWordsByAlphabet }
  
      header.setHeader(total: calculateNumOfWords(list: list))
      return header
    }
    return UIView()
  }
  
  private func calculateNumOfWords(list: [WordsList]) -> Int{
    var counter = 0
    for word in list{
      counter += word.count
    }
    return counter
  }
  
}

//MARK: CollectionView Delegates
extension SortedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func setCollectionView(){
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: 30, height: 30)
    flowLayout.scrollDirection = .horizontal
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.collectionViewLayout =  flowLayout

    let indexPath = IndexPath(row: model?.collectionViewCellSelected ?? 0, section: 0)
    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
    filterWordsByAlphabet(pickerData[model?.collectionViewCellSelected ?? 0])
  }

  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pickerData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
      cell.cellLbl.text = pickerData[indexPath.row]
      return cell
    }
    
    return UICollectionViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      model?.collectionViewCellSelected = indexPath.row
      filterWordsByAlphabet(pickerData[indexPath.row])
  }
  
  private func filterWordsByAlphabet(_ letter: String){
    if letter != "All"{
      filteredWordsByAlphabet = wordsList.filter({ $0.word.first?.lowercased() == letter.lowercased()})
    } else{
      filteredWordsByAlphabet = wordsList
    }
    tableView.reloadData()
  }
}
