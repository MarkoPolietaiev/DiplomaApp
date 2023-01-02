//
//  MainViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    var postings: [Posting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    private func setupView() {
        self.hideNavigationBar()
        self.addButton.layer.cornerRadius = 15
        self.tableView.register(R.nib.postingTableViewCell)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    private func getData() {
        self.networkManager.getPostings { response, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let response = response {
                self.postings = response
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func openPostingDetail(_ posting: Posting? = nil) {
        if let vc = R.storyboard.main.postingViewController() {
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            vc.posting = posting
            self.present(vc, animated: true)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.getData()
    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        if let vc = R.storyboard.profile.profileViewController() {
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.openPostingDetail()
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.noDataLabel.isHidden = self.postings.count > 0
        return self.postings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.postingTableViewCell, for: indexPath)!
        let item = self.postings[indexPath.row]
        cell.setupWithPosting(item)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            self.openPostingDetail(self.postings[indexPath.row])
            handler(false)
        }
        editAction.backgroundColor = .gray
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, handler) in
            let item = self.postings[indexPath.row]
            if let id = item.id {
                self.networkManager.deletePosting(id: id) { error in
                    if let error = error {
                        self.showErrorAlert(message: error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self.postings.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: .left)
                        }
                    }
                }
            }
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [editAction,deleteAction])
        return configuration
    }
}
