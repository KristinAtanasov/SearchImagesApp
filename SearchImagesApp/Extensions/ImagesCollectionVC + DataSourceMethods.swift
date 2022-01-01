// CollectionView Data Source methods

import UIKit

extension ImagesCollectionViewController{
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
       
       override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
           return resultURLS.count
       }
       
       override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
           
           let cellImageURL = resultURLS[indexPath.row].urls.regular
           
           cell.configureImageCell(with: cellImageURL)
           
           return cell
       }
}
