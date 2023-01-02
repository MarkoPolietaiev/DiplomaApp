//
//  FeedViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-11.
//

import UIKit

class FeedViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feed"
        self.setupDataSource()
    }
    
    private func setupDataSource() {
        self.tableView.register(R.nib.feedTableViewCell)
        self.populateData()
        self.tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.feedTableViewCell, for: indexPath)!
        let item = self.posts[indexPath.row]
        cell.setupWithPost(item)
        cell.moreAction = {
            self.goToPostDetail(item)
        }
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let ratio = self.posts[indexPath.row].image.size.width/self.posts[indexPath.row].image.size.height
        return (self.view.frame.width/ratio) + 90
    }
}

// MARK: Temporar solution
private extension FeedViewController {
    func populateData() {
//
//        let user1 = User(username: "some_user", image: R.image.user1()!, stats: [])
//        let user2 = User(username: "dow_Jones", image: R.image.user2()!, stats: [])
//        let user3 = User(username: "*John*Smith*", image: R.image.user3()!, stats: [])
//
//        let skill1 = Skill(title: "Skill 1", user: user1, image: R.image.skill1()!)
//        let skill2 = Skill(title: "Skill 2", user: user1, image: R.image.skill2()!)
//
//        let skill3 = Skill(title: "Skill 3", user: user2, image: R.image.skill3()!)
//        let skill4 = Skill(title: "Skill 4", user: user2, image: R.image.skill4()!)
//        let skill5 = Skill(title: "Skill 5", user: user2, image: R.image.skill5()!)
//
//        let skill6 = Skill(title: "Skill 6", user: user3, image: R.image.skill6()!)
//        let skill7 = Skill(title: "Skill 7", user: user3, image: R.image.skill7()!)
//        let skill8 = Skill(title: "Skill 8", user: user3, image: R.image.skill8()!)
//
//        let step1 = Step(title: "Step 1", description: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versio from the 1914 translation by H. Rackham.", images: [R.image.post1()!, R.image.skill6()!, R.image.post5()!])
//        let step2 = Step(title: "Step 2", description: "Description for step 2", images: [R.image.post2()!, R.image.skill6()!, R.image.post5()!])
//        let step3 = Step(title: "Step 3", description: "Description for step 3", images: [R.image.post3()!, R.image.skill6()!, R.image.post5()!])
//
//        let post1 = Post(skill: skill1, title: "Post 1", image: R.image.post1()!, steps: [step1, step2, step3])
//        let post2 = Post(skill: skill2, title: "Post 2", image: R.image.post2()!, steps: [step1, step2, step3])
//        let post3 = Post(skill: skill1, title: "Post 3", image: R.image.post3()!, steps: [step1, step2, step3])
//        let post4 = Post(skill: skill2, title: "Post 4", image: R.image.post4()!, steps: [step1, step2, step3])
//        let post5 = Post(skill: skill1, title: "Post 5", image: R.image.post5()!, steps: [step1, step2, step3])
//
//        let post6 = Post(skill: skill3, title: "Post 6", image: R.image.post6()!, steps: [step1, step2, step3])
//        let post7 = Post(skill: skill4, title: "Post 7", image: R.image.post1()!, steps: [step1, step2, step3])
//        let post8 = Post(skill: skill5, title: "Post 8", image: R.image.post2()!, steps: [step1, step2, step3])
//        let post9 = Post(skill: skill4, title: "Post 9", image: R.image.post3()!, steps: [step1, step2, step3])
//        let post10 = Post(skill: skill3, title: "Post 10", image: R.image.post4()!, steps: [step1, step2, step3])
//
//        let post11 = Post(skill: skill6, title: "Post 11", image: R.image.post5()!, steps: [step1, step2, step3])
//        let post12 = Post(skill: skill6, title: "Post 12", image: R.image.post6()!, steps: [step1, step2, step3])
//        let post13 = Post(skill: skill7, title: "Post 13", image: R.image.post1()!, steps: [step1, step2, step3])
//        let post14 = Post(skill: skill8, title: "Post 14", image: R.image.post2()!, steps: [step1, step2, step3])
//        let post15 = Post(skill: skill8, title: "Post 15", image: R.image.post3()!, steps: [step1, step2, step3])
//
//
//        self.posts.append(contentsOf: [post1,post2,post3,post4,post5,post6,post7,post8,post9,post10,post11,post12,post13,post14,post15])
    }
}

