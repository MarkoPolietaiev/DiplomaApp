//
//  MainViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2022-12-29.
//

import UIKit

class MainViewController: BaseViewController, StepViewControllerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goalsButton: UIButton!
    @IBOutlet weak var tagsButton: UIButton!
    @IBOutlet weak var stepsButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    let tagsRefreshControl = UIRefreshControl()
    let stepsRefreshControl = UIRefreshControl()
    
    var postings: [Posting] = []
    var tags: [Tag] = []
    var steps: [Step] = []
    
    var selectedItem: SelectedItem = .postings {
        didSet {
            switch self.selectedItem {
            case .postings:
                self.showGoals()
            case .steps:
                self.showSteps()
            case .tags:
                self.showTags()
            }
        }
    }
    enum SelectedItem {
        case postings
        case tags
        case steps
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: .updatePostingsList, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getSteps), name: .updateStepsList, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
        self.getTags()
        self.getSteps()
    }
    
    private func setupView() {
        self.hideNavigationBar()
        self.setupLayout()
        self.addButton.layer.cornerRadius = 15
        self.tableView.register(R.nib.postingTableViewCell)
        self.collectionView.register(R.nib.tagCollectionViewCell)
        self.stepsCollectionView.register(R.nib.stepCollectionViewCell)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        self.tagsRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        self.tagsRefreshControl.addTarget(self, action: #selector(self.refreshTags(_:)), for: .valueChanged)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.addSubview(tagsRefreshControl)
        
        self.stepsRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        self.stepsRefreshControl.addTarget(self, action: #selector(self.refreshSteps(_:)), for: .valueChanged)
        self.stepsCollectionView.alwaysBounceVertical = true
        self.stepsCollectionView.addSubview(stepsRefreshControl)
        self.showGoals()
    }
    
    private func setupLayout() {
        let width = (self.view.frame.width/3)-30
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 50, right: 15)
        self.collectionView.collectionViewLayout = layout
        
        let stepsLayout = UICollectionViewFlowLayout()
        stepsLayout.scrollDirection = .vertical
        stepsLayout.itemSize = CGSize(width: width, height: width)
        stepsLayout.minimumLineSpacing = 15
        stepsLayout.minimumInteritemSpacing = 15
        stepsLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 50, right: 15)
        self.stepsCollectionView.collectionViewLayout = stepsLayout
    }
    
    @objc private func getData() {
        self.networkManager.getPostings { response, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let response = response {
                self.postings = response
                DispatchQueue.main.async {
                    self.setupNoDataLabel()
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func getTags() {
        self.networkManager.getTags { response, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let response = response {
                self.tags = response
                DispatchQueue.main.async {
                    self.setupNoDataLabel()
                    self.tagsRefreshControl.endRefreshing()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc private func getSteps() {
        self.networkManager.getSteps { response, error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else if let response = response {
                self.steps = response
                DispatchQueue.main.async {
                    self.setupNoDataLabel()
                    self.stepsRefreshControl.endRefreshing()
                    self.stepsCollectionView.reloadData()
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
    
    private func showDeleteAlert(_ indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this goal?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deletePosting(indexPath)
        }))
        self.present(alert, animated: true)
    }
    
    private func deletePosting(_ indexPath: IndexPath) {
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
    
    private func showTags() {
        self.titleLabel.text = "Your Tags"
        self.setupNoDataLabel()
        
        self.tagsButton.setImage(UIImage(systemName: "doc.fill"), for: .normal)
        self.stepsButton.setImage(UIImage(systemName: "list.bullet.rectangle.portrait"), for: .normal)
        self.goalsButton.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        
        self.addButton.isHidden = true
        
        self.tableView.isHidden = true
        self.stepsCollectionView.isHidden = true
        self.collectionView.isHidden = false
    }
    
    private func showGoals() {
        self.titleLabel.text = "Your Motivation List"
        self.setupNoDataLabel()
        
        self.tagsButton.setImage(UIImage(systemName: "doc"), for: .normal)
        self.stepsButton.setImage(UIImage(systemName: "list.bullet.rectangle.portrait"), for: .normal)
        self.goalsButton.setImage(UIImage(systemName: "checkmark.rectangle.portrait.fill"), for: .normal)
        
        self.addButton.isHidden = false
        
        self.tableView.isHidden = false
        self.collectionView.isHidden = true
        self.stepsCollectionView.isHidden = true
    }
    
    private func showSteps() {
        self.titleLabel.text = "Your Steps"
        self.setupNoDataLabel()
        
        self.tagsButton.setImage(UIImage(systemName: "doc"), for: .normal)
        self.stepsButton.setImage(UIImage(systemName: "list.bullet.rectangle.portrait.fill"), for: .normal)
        self.goalsButton.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        
        self.addButton.isHidden = true
        
        self.tableView.isHidden = true
        self.collectionView.isHidden = true
        self.stepsCollectionView.isHidden = false
    }
    
    private func setupNoDataLabel() {
        switch self.selectedItem {
        case .postings:
            self.noDataLabel.isHidden = self.postings.count > 0
        case .tags:
            self.noDataLabel.isHidden = self.tags.count > 0
        case .steps:
            self.noDataLabel.isHidden = self.steps.count > 0
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.getData()
    }
    
    @objc func refreshTags(_ sender: AnyObject) {
        self.getTags()
    }
    
    @objc func refreshSteps(_ sender: AnyObject) {
        self.getSteps()
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
    
    @IBAction func tagsButtonPressed(_ sender: Any) {
        self.selectedItem = .tags
    }
    
    @IBAction func stepsButtonPressed(_ sender: Any) {
        self.selectedItem = .steps
    }
    
    @IBAction func goalsButtonPressed(_ sender: Any) {
        self.selectedItem = .postings
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            self.showDeleteAlert(indexPath)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [editAction,deleteAction])
        return configuration
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.tags.count
        } else {
            return self.steps.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.tagCollectionViewCell, for: indexPath)!
            let item = self.tags[indexPath.item]
            cell.delegate = self
            cell.setupWithTag(item, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.stepCollectionViewCell, for: indexPath)!
            let item = self.steps[indexPath.item]
            cell.delegate = self
            cell.setupWithStep(item, indexPath: indexPath)
            return cell
        }
    }
}

extension MainViewController: TagCollectionViewCellDelegate {
    func deleteTag(_ indexPath: IndexPath) {
        guard let id = self.tags[indexPath.item].id else {return}
        self.networkManager.deleteTag(id: id) { error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.tags.remove(at: indexPath.item)
                    self.collectionView.deleteItems(at: [indexPath])
                    for index in 0...self.tags.count-1 {
                        if let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TagCollectionViewCell {
                            cell.indexPath = IndexPath(item: index, section: 0)
                        }
                    }
                }
            }
        }
    }
    
    func editTag(_ indexPath: IndexPath) {
        self.showEditTagAlert(indexPath)
        
    }
    
    private func showEditTagAlert(_ indexPath: IndexPath) {
        let ac = UIAlertController(title: "Enter Tag's name.", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.textFields![0].text = self.tags[indexPath.item].name
        ac.textFields![0].placeholder = "Enter Tag's name"
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            if let name = ac.textFields![0].text {
                let tag = Tag(name: name)
                guard let id = self.tags[indexPath.item].id else {return}
                self.networkManager.updateTag(id: id, tag: tag) { response, error in
                    if let error = error {
                        self.showErrorAlert(message: error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self.getTags()
                        }
                    }
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancel)
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

extension MainViewController: StepCollectionViewCellDelegate {
    
    func editStep(_ indexPath: IndexPath) {
        if let vc = R.storyboard.main.stepViewController() {
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .pageSheet
            vc.delegate = self
            vc.step = self.steps[indexPath.item]
            if #available(iOS 15.0, *) {
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [.medium()]
                }
            } else {
                // Fallback on earlier versions
            }
            self.present(vc, animated: true)
        }
    }
    
    func deleteStep(_ indexPath: IndexPath) {
        guard let id = self.steps[indexPath.item].id else {return}
        self.networkManager.deleteStep(id: id) { error in
            if let error = error {
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.steps.remove(at: indexPath.item)
                    self.stepsCollectionView.deleteItems(at: [indexPath])
                    for index in 0...self.steps.count-1 {
                        if let cell = self.stepsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? StepCollectionViewCell {
                            cell.indexPath = IndexPath(item: index, section: 0)
                        }
                    }
                }
            }
        }
    }
}
