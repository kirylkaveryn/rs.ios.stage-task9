//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSTextLabel: RSContentTypeLabel {

    var topInset: CGFloat = 30.0
    var bottomInset: CGFloat = 40.0
    var leftInset: CGFloat = 30.0
    var rightInset: CGFloat = 30.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font.withSize(24.0)
        self.textAlignment = .left
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}
