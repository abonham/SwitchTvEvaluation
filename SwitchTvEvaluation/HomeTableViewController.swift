//
//  HomeTableViewController.swift
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    fileprivate let reuseID = "cell"
    private var feed: ContentFeed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = "Switch Media"
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleFeedRefreshed), name: .feedRefreshSuccessful, object: nil)
        
        tableView.register(SectionCollectionViewCell.self, forCellReuseIdentifier: reuseID)
        
        feed = FeedProvider.sharedInstance.feed
    }
    
    @objc func handleFeedRefreshed(notification: Notification) {
        feed = FeedProvider.sharedInstance.feed
        tableView.reloadData()
    }

}

extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return feed?.categories.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return feed?.categories[section].category
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .lightGray
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! SectionCollectionViewCell
        
        var orientation: ContentOrientation
        
        switch indexPath.section {
        case 0:
            orientation = .landscape
        default:
            orientation = .portrait
        }
        
        if let category = feed?.categories[indexPath.section]
        {
            cell.configureForSection(orientation: orientation, category: category, delegate: self)
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return ContentOrientation.landscape.size.height
        default:
            return ContentOrientation.portrait.size.height
        }
    }
}

extension HomeTableViewController: SectionCellDelegate {
    func didSelect(item: ContentItem) {
        let detailViewController = ItemDetailViewController()
        detailViewController.configure(for: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
