

import UIKit

class ShowSelectedImageViewController: UIViewController {
    
    @IBOutlet var showSelectedImageView: UIImageView!
    
    var imageURL: String
    
    init?(coder: NSCoder, imageURL: String) {
        self.imageURL = imageURL
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("The init(coder: ) has not been initialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureImageCell(with: imageURL)
    }
    
    func configureImageCell(with urlString: String){
        guard let url = URL(string: urlString) else{return}
        
        let taskRequest = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.showSelectedImageView.image = image
                }
            }
            else{
                print(error)
            }
        }
        taskRequest.resume()
    }
}

