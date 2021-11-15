//
//  SearchViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-11.
//

import UIKit
import SquareFlowLayout

class SearchViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupDataSource()
    }
    
    private func setupDataSource() {
        self.collectionView.register(R.nib.searchCollectionViewCell)
        self.populateData()
        self.collectionView.reloadData()
    }
    
    private func setupLayout() {
        let layout = SquareFlowLayout()
        layout.flowDelegate = self
        self.collectionView.collectionViewLayout = layout
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
            self.goToPostDetail(item)
        }
        return cell
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: SquareFlowLayoutDelegate {
    
    func shouldExpandItem(at indexPath: IndexPath) -> Bool {
        return indexPath.item % 5 == 0
    }
    
}

private extension SearchViewController {
    func populateData() {
        
        let user1 = User(username: "some_user", image: R.image.user1()!, stats: [])
        let user2 = User(username: "dow_Jones", image: R.image.user2()!, stats: [])
        let user3 = User(username: "*John*Smith*", image: R.image.user3()!, stats: [])
        
        let skill1 = Skill(title: "Skill 1", user: user1, image: R.image.skill1()!)
        let skill2 = Skill(title: "Skill 2", user: user1, image: R.image.skill2()!)
        
        let skill3 = Skill(title: "Skill 3", user: user2, image: R.image.skill3()!)
        let skill4 = Skill(title: "Skill 4", user: user2, image: R.image.skill4()!)
        let skill5 = Skill(title: "Skill 5", user: user2, image: R.image.skill5()!)
        
        let skill6 = Skill(title: "Skill 6", user: user3, image: R.image.skill6()!)
        let skill7 = Skill(title: "Skill 7", user: user3, image: R.image.skill7()!)
        let skill8 = Skill(title: "Skill 8", user: user3, image: R.image.skill8()!)
        
        let step1 = Step(title: "Step 1", description: "Description for step 1", images: [R.image.post1()!])
        let step2 = Step(title: "Step 2", description: "Description for step 2", images: [R.image.post2()!])
        let step3 = Step(title: "Step 3", description: "Description for step 3", images: [R.image.post3()!])
        
        let post1 = Post(skill: skill1, title: "How I learn something at home, bla bla bla...", image: R.image.post1()!, steps: [step1, step2, step3])
        let post2 = Post(skill: skill2, title: "How I learn something at home, bla bla bla...", image: R.image.post2()!, steps: [step1, step2, step3])
        let post3 = Post(skill: skill1, title: "Post 3", image: R.image.post3()!, steps: [step1, step2, step3])
        let post4 = Post(skill: skill2, title: "Post 4", image: R.image.post4()!, steps: [step1, step2, step3])
        let post5 = Post(skill: skill1, title: "Post 5", image: R.image.post5()!, steps: [step1, step2, step3])
        
        let post6 = Post(skill: skill3, title: "How I learn something at home, bla bla bla...", image: R.image.post6()!, steps: [step1, step2, step3])
        let post7 = Post(skill: skill4, title: "Post 7", image: R.image.post1()!, steps: [step1, step2, step3])
        let post8 = Post(skill: skill5, title: "Post 8", image: R.image.post2()!, steps: [step1, step2, step3])
        let post9 = Post(skill: skill4, title: "How I learn something at home, bla bla bla...", image: R.image.post3()!, steps: [step1, step2, step3])
        let post10 = Post(skill: skill3, title: "Post 10", image: R.image.post4()!, steps: [step1, step2, step3])
        
        let post11 = Post(skill: skill6, title: "How I learn something at home, bla bla bla...", image: R.image.post5()!, steps: [step1, step2, step3])
        let post12 = Post(skill: skill6, title: "How I learn something at home, bla bla bla...", image: R.image.post6()!, steps: [step1, step2, step3])
        let post13 = Post(skill: skill7, title: "Post 13", image: R.image.post1()!, steps: [step1, step2, step3])
        let post14 = Post(skill: skill8, title: "Post 14", image: R.image.post2()!, steps: [step1, step2, step3])
        let post15 = Post(skill: skill8, title: "Post 15", image: R.image.post3()!, steps: [step1, step2, step3])
        
        
        self.posts.append(contentsOf: [post1,post2,post3,post4,post5,post6,post7,post8,post9,post10,post11,post12,post13,post14,post15])
    }
}


