//
//  BranchesViewController.swift
//  ContinuousKit
//
//  Created by Kevin Lundberg on 9/30/17.
//  Copyright © 2017 Kevin Lundberg. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct BranchViewModel {
    var name: String
}

class BranchNameCell: UICollectionViewCell {
    static let identifier = "\(BranchNameCell.self)"
    var nameLabel: UILabel

    override init(frame: CGRect) {
        nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)

        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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

    var layout: UICollectionViewFlowLayout {
        return collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white

        presenter?.loadContent()
        collectionView?.register(BranchNameCell.self, forCellWithReuseIdentifier: BranchNameCell.identifier)

        layout.itemSize = CGSize(width: view.bounds.width, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return branches.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BranchNameCell.identifier, for: indexPath) as! BranchNameCell

        cell.nameLabel.text = branches[indexPath.item].name

        return cell
    }
}
