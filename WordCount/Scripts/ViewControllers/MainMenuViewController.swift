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

  

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    // Do any additional setup after loading the view.
  }
  
  private func configureUI(){
    
    self.view.backgroundColor = .white
    mainTitleLbl.textColor = ExtraInfo.mainColor
    mainTitleLbl.text = "Word Counter"
    
    buttonLoadText1.setButton(name: "Primer Boton", border: true)
    buttonLoadText2.setButton(name: "Segundo Boton", border: true)
    buttonLoadText3.setButton(name: "Tercer Boton", border: true)
  }
  
  
  func goToNextScreen(title: String){
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let vC = storyBoard.instantiateViewController(withIdentifier: "SortedViewController") as? SortedViewController else{
      print("Couldn't open SortedViewController")
      return
    }
    vC.navigationItem.title = title
    self.navigationController?.pushViewController(vC, animated: true)
  }
  
  
  // MARK: IBOutlets Actions
  @IBAction func onClickButton1(_ sender: Any) {
    goToNextScreen(title: "Primer boton")
  }
  
  @IBAction func onClickButton2(_ sender: Any) {
    goToNextScreen(title: "Segundo boton")
  }
  
  @IBAction func onClickButton3(_ sender: Any) {
    goToNextScreen(title: "Tercer boton")
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



