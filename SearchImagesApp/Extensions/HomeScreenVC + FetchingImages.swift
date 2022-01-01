// The extensions holding the methods for fetching images

import UIKit

extension HomeScreenViewController{
    
    func fetchCategoryImages(){
        if let categoryImages = textField.text{
            self.fetchImageURLS(query: categoryImages)
        }
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
}
