//
//  ActionsViewController.swift
//  Diploma
//
//  Created by Marko Polietaiev on 2021-07-11.
//

import UIKit

class ActionsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var notifications: [Notification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDataSource()
    }
    
    private func setupDataSource() {
        self.tableView.register(R.nib.notificationTableViewCell)
        self.populateData()
        self.tableView.reloadData()
    }

}

extension ActionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ActionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.notificationTableViewCell, for: indexPath)!
        let item = self.notifications[indexPath.row]
        cell.setupWithNotification(item)
        return cell
    }
    
}

private extension ActionsViewController {
    func populateData() {
        let notification1 = Notification(title: "Someone liked your post")
        let notification2 = Notification(title: "Someone subscribed on your programming skill aim")
        let notification3 = Notification(title: "Someone liked your comment")
        let notification4 = Notification(title: "Someone subscribed on your skating skill aim")
        let notification5 = Notification(title: "Someone subscribed on your fast reading skill aim")
        
        self.notifications.append(contentsOf: [notification1,notification2,notification3,notification4,notification5])
    }
}

