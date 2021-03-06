//
//  ViewController.swift
//  DemoFastScroll
//
//  Created by Arsene Huot on 14/06/2018.
//  Copyright © 2018 Frichti. All rights reserved.
//

import UIKit

class DemoLargeBubbleCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: FastScrollCollectionView!
    
    fileprivate var data: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        data = Utils.fakeLargeData()
        configFastScroll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

// MARK: Helpers

extension DemoLargeBubbleCollectionViewController {
    fileprivate func configFastScroll() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //bubble
        collectionView.bubbleTextSize = 14.0
        collectionView.bubbleMarginRight = 60.0
        collectionView.bubbleColor = UIColor(red: 38.0 / 255.0, green: 48.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
        
        //handle
        collectionView.handleImage = UIImage.init(named: "cursor")
        collectionView.handleHeight = 40.0
        collectionView.handleWidth = 44.0
        collectionView.handleRadius = 0.0
        collectionView.handleMarginRight = 0
        collectionView.handleColor = UIColor.clear
        
        //scrollbar
        collectionView.scrollbarWidth = 0.0
        collectionView.scrollbarMarginTop = 20.0
        collectionView.scrollbarMarginBottom = 0.0
        collectionView.scrollbarMarginRight = 10.0
        
        //callback action to display bubble name
        collectionView.bubbleNameForIndexPath = { indexPath in
            let visibleSection: Section = self.data[indexPath.section]
            return visibleSection.sectionTitle
        }
    }
    
    fileprivate func registerCell() {
        collectionView?.register(UINib(nibName: String(describing: ItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))
        collectionView?.register(UINib(nibName: String(describing: SectionView.self), bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: SectionView.self))
    }
}


// MARK: UICollectionViewDelegate

extension DemoLargeBubbleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ItemCollectionViewCell else { return }
        
        let item = data[indexPath.section].items[indexPath.row]
        cell.titleLabel.text = item.title
    }
}

// MARK: UICollectionViewDataSource

extension DemoLargeBubbleCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCollectionViewCell.self), for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = data[indexPath.section]
        let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: SectionView.self), for: indexPath) as! SectionView
        
        sectionView.title.text = section.sectionTitle
        return sectionView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DemoLargeBubbleCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

// MARK: - UIScrollViewDelegate

extension DemoLargeBubbleCollectionViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        collectionView.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionView.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        collectionView.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}




