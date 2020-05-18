//
//  TableCell.swift
//  TeratailPagingCellSample
//
//  Created by 山田隼也 on 2020/05/18.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    // MARK: IBOutlet

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageVIew: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "TableCell"
    static var nib: UINib {
        return UINib(nibName: "TableCell", bundle: nil)
    }
    
    var onScrollViewDidEndDecelerating: ((_ page: Int) -> Void)?
    
    // MARK: Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //scrollView.delegate = nil
    }
    
    func configure(with page: Int, descriptionText: String?) {
        //scrollView.delegate = self
        pageControl.currentPage = page
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(page), y: 0), animated: false)
        descriptionLabel.text = descriptionText
    }
}

extension TableCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
        
        if let onScrollViewDidEndDecelerating = onScrollViewDidEndDecelerating {
            onScrollViewDidEndDecelerating(page)
        }
    }
}
