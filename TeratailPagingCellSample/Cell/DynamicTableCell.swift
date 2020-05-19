//
//  DynamicTableCell.swift
//  TeratailPagingCellSample
//
//  Created by 山田隼也 on 2020/05/19.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit

class DynamicTableCell: UITableViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "DynamicTableCell"
    static var nib: UINib {
        return UINib(nibName: "DynamicTableCell", bundle: nil)
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
        
        // NOTE: Remove sub views
        scrollStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
            scrollStackView.removeArrangedSubview($0)
        }
    }
    
    func configure(with page: Int, images: [UIImage], descriptionText: String?) {
        pageControl.currentPage = page
        pageControl.numberOfPages = images.count
        
        images.forEach {
            let imageView = UIImageView(image: $0)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
            scrollStackView.addArrangedSubview(imageView)
        }
        
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(page), y: 0), animated: false)
        descriptionLabel.text = descriptionText
    }
}

extension DynamicTableCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
        
        if let onScrollViewDidEndDecelerating = onScrollViewDidEndDecelerating {
            onScrollViewDidEndDecelerating(page)
        }
    }
}
