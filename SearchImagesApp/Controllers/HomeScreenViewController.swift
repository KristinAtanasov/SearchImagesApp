// The HomeScreen controller

import UIKit

class HomeScreenViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var showResultsButton: UIButton!
    
    var resultURLS = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        textField.becomeFirstResponder()
        
        buttonsBordersConfiguration()
        showResultsButton.isHidden = true
    }
    
    // MARK: - Keyboard methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - UI button methods
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        self.fetchCategoryImages()
        searchButton.isHidden = true
        showResultsButton.backgroundColor = #colorLiteral(red: 0, green: 0.9294117647, blue: 0, alpha: 1)
        showResultsButton.isHidden = false
    }
    func buttonsBordersConfiguration(){
        searchButton.layer.cornerRadius = 10
        showResultsButton.layer.cornerRadius = 10
    }
    
    //MARK: - Segue methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToCollectionController"{
            if let destinationVC = segue.destination as? ImagesCollectionViewController{
                destinationVC.resultURLS = self.resultURLS
            }
        }
    }
    
    @IBAction func showResultsOnCollectionController(_ sender: UIButton) {
        self.performSegue(withIdentifier: "moveToCollectionController", sender: nil)
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue){
        if segue.identifier == "returnToHomeScreen"{
            self.resultURLS = []
            
            showResultsButton.isHidden = true
            searchButton.isHidden = false
        }
    }
}

