//
//  SearchViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-11.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func goToPost(_ post: Post) {
        
    }

}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.searchCollectionViewCell, for: indexPath)!
        let item = self.posts[indexPath.item]
        cell.setupWithPost(item)
        cell.selectAction = {
            self.goToPost(item)
        }
        return cell
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    
}
