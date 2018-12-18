//
//  HitsViewController.swift
//  Engineer Ai Assignment
//
//  Created by Zhandos Bolatbekov on 12/18/18.
//  Copyright © 2018 zhandos. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

class HitsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    var hits = [Hit]()
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureInfiniteScroll()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        
        tableView.reloadData()
    }
    
    private func configureInfiniteScroll() {
        tableView.addInfiniteScroll { [unowned self] tableView in
            self.fetchNextPage {
                tableView.reloadData()
                tableView.finishInfiniteScroll()
                self.navigationBar.topItem?.title = "\(self.hits.count)"
            }
        }
        tableView.infiniteScrollTriggerOffset = 1500
        tableView.beginInfiniteScroll(true)
    }
    
    private func fetchNextPage(completion: (() -> Void)? = nil) {
        Hit.getHits(inPage: page + 1) { [unowned self] hits in
            self.page += 1
            self.hits.append(contentsOf: hits)
            completion?()
        }
    }
}

extension HitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Hit Cell", for: indexPath) as! HitTableViewCell
        cell.hit = hits[indexPath.row]
        return cell
    }
}
