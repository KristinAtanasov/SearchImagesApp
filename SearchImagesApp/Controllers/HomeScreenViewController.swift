

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var showResultsButton: UIButton!
    
    var resultURLS = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        
        searchButton.layer.cornerRadius = 10
        showResultsButton.layer.cornerRadius = 10
        showResultsButton.isHidden = true
        
    }
    
    
    func fetchImageURLS(query: String){
        let stringURL = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=yOpkJ9GeI36-HPTdTZZfG2iIR5scgbXSMNXvSwUPMjw"
        let safeURLString = stringURL.replacingOccurrences(of: " ", with: "-")
        
        guard let url = URL(string: safeURLString) else {return}
        
        let taskRequest = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let apiResponseData = try jsonDecoder.decode(ApiResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.resultURLS = apiResponseData.results
                    }
                } catch  {
                    print(error)
                }
            }
        }
        taskRequest.resume()
    }
    func fetchCategoryImages(){
        if let categoryImages = textField.text{
            self.fetchImageURLS(query: categoryImages)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToCollectionController"{
            if let destinationVC = segue.destination as? ImagesCollectionViewController{
                destinationVC.resultURLS = self.resultURLS
            }
        }
    }
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        self.fetchCategoryImages()
        textField.resignFirstResponder()
        searchButton.isHidden = true
        showResultsButton.backgroundColor = #colorLiteral(red: 0, green: 0.9294117647, blue: 0, alpha: 1)
        showResultsButton.isHidden = false
    }
    
  @IBAction func showResultsOnCollectionController(_ sender: UIButton) {
        self.performSegue(withIdentifier: "moveToCollectionController", sender: nil)
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue){
        if segue.identifier == "returnToHomeScreen"{
            self.resultURLS = []
            textField.becomeFirstResponder()
            showResultsButton.isHidden = true
            searchButton.isHidden = false
        }
    }
}

