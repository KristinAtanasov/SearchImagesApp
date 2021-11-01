

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    
    var resultURLS = [Result]()
    let stringURL = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=office&client_id=yOpkJ9GeI36-HPTdTZZfG2iIR5scgbXSMNXvSwUPMjw"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 10
        fetchPhotos(query: "office")

    }

    
    
    func fetchPhotos(query: String){
        let stringURL = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=yOpkJ9GeI36-HPTdTZZfG2iIR5scgbXSMNXvSwUPMjw"
        guard let url = URL(string: stringURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {
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
        task.resume()
    }
    
    @IBSegueAction func searchButtonTapped(_ coder: NSCoder) -> PhotosCollectionViewController? {
        
        let resultURLS = self.resultURLS
        
        return PhotosCollectionViewController(coder: coder, resultURLS: resultURLS)
    }
    
    
    
    
   @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue){
        
    }
}

