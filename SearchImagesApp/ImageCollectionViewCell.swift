

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var cellImageView: UIImageView!
    
    
    func configureImageCell(with urlString: String){
        guard let url = URL(string: urlString) else{return}
        
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.cellImageView.image = image
                }
            }
            else{
             print(error)
            }
        }
        task.resume()
    }
}
