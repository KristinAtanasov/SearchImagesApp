//  Controller responsible for displaying the fetched images in the cells

import UIKit

class ImagesCollectionViewController: UICollectionViewController {
    
    lazy var reuseIdentifier = "Cell"
    
    var resultURLS = [Result]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }
    
    //MARK: - Configure cells layout
    
    private func generateLayout() -> UICollectionViewLayout{
        let spacing: CGFloat = 5
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 3,
            leading: spacing,
            bottom: 0,
            trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(190.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: 3,
            bottom: 0,
            trailing: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    //MARK: - IB Actions
    
    @IBSegueAction func showSelectedImage(_ coder: NSCoder, sender: Any?) -> ShowSelectedImageViewController? {
        if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell){
            
            let imageURL = resultURLS[indexPath.row].urls.regular
            return ShowSelectedImageViewController(coder: coder, imageURL: imageURL )
        }
        else{
            return ShowSelectedImageViewController(coder: coder)
        }
    }
}


