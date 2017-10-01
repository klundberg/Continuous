//
//  BranchesViewController.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 9/30/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import UIKit

struct BranchViewModel {
    var name: String
}

class BranchesViewController: UICollectionViewController {
    var presenter: BranchesPresenter?

    var branches: [BranchViewModel] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.loadContent()
    }
}
