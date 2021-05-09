//
//  MainMenuViewController.swift
//  WordCount
//
//  Created by Anna Ponce on 07/05/2021.
//

import UIKit

class MainMenuViewController: UIViewController {

  @IBOutlet weak var mainTitleLbl: UILabel!
  
  @IBOutlet weak var buttonLoadText1: UIButton!
  @IBOutlet weak var buttonLoadText2: UIButton!
  @IBOutlet weak var buttonLoadText3: UIButton!
  
  private let model = ViewModel()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    // Do any additional setup after loading the view.
  }
  
  private func configureUI(){
    
    self.view.backgroundColor = .white
    mainTitleLbl.textColor = ExtraInfo.mainColor
    mainTitleLbl.text = "Word Counter"
    
    buttonLoadText1.setButton(name: ButtonsID.namesFile.buttonName, border: true)
    buttonLoadText2.setButton(name: ButtonsID.aliceFile.buttonName, border: true)
    buttonLoadText3.setButton(name: ButtonsID.paradiseFile.buttonName, border: true)
  }
  
  
  func goToNextScreen(title: String){
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let vC = storyBoard.instantiateViewController(withIdentifier: "SortedViewController") as? SortedViewController else{
      print("Couldn't open SortedViewController")
      return
    }
    vC.navigationItem.title = title
    vC.model = model
    self.navigationController?.pushViewController(vC, animated: true)
  }
  
  
  // MARK: IBOutlets Actions
  @IBAction func onClickButton1(_ sender: Any) {
    model.loadText(fileName: ButtonsID.namesFile.fileName)
    goToNextScreen(title: ButtonsID.namesFile.buttonName)
  }
  
  @IBAction func onClickButton2(_ sender: Any) {
    model.loadText(fileName: ButtonsID.aliceFile.fileName)
    goToNextScreen(title: ButtonsID.aliceFile.buttonName)
  }
  
  @IBAction func onClickButton3(_ sender: Any) {
    model.loadText(fileName: ButtonsID.paradiseFile.fileName)
    goToNextScreen(title: ButtonsID.paradiseFile.buttonName)
  }
  
}

// MARK: NavigationBar
extension MainMenuViewController{
  override func viewWillDisappear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
    super.viewWillDisappear(animated)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
}

// MARK: ButtonsID Enum
extension MainMenuViewController{
  enum ButtonsID{
    case namesFile
    case aliceFile
    case paradiseFile
    
    var buttonName: String{
      switch self {
      case .namesFile:
        return "Nombres"
      case .aliceFile:
        return "Alice's adventures in Wonderland"
      case .paradiseFile:
        return "Paradise Lost"
      }
    }
    
    var fileName: String{
      switch self {
      case .namesFile:
        return "Nombres"
      case .aliceFile:
        return "Alice"
      case .paradiseFile:
        return "Paradise"
      }
    }
  }
}



