//
//  FlickrCommentTableViewCell.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - FlickrCommentTableViewCell

final class FlickrCommentTableViewCell: UITableViewCell, PreparedConfigurable {
    
    private let authorLabel  = FlickrCommentTableViewCellStyleSheet.Label.author.label
    private let contentLabel = FlickrCommentTableViewCellStyleSheet.Label.content.label
    
    let mainStackView = FlickrCommentTableViewCellStyleSheet.StackView.main.stackView
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defer { prepare() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Preparable Conformance
    
    func prepare() {
        defer { FlickrCommentTableViewCellStyleSheet.prepare(self) }
        mainStackView.addArrangedSubviews <| [authorLabel, contentLabel]
        addSubview(mainStackView)
    }
    
    // MARK: - Configurable Conformance
    
    func configure(_ comment: FlickrPhotoComment) {
        defer { prepare() }
        authorLabel.text =  comment.ownerName
        contentLabel.text = comment.content
    }
}

// MARK: - FlickrCommentTableViewCellStyleSheet

fileprivate struct FlickrCommentTableViewCellStyleSheet: ViewPreparer {
    
    fileprivate static func prepare(_ commentCell: FlickrCommentTableViewCell) {
        
        commentCell.backgroundColor = .clear
        
        defer { commentCell.layoutIfNeeded() }
        
        let stackViewTop      = ¿NSLayoutConstraint.init <| commentCell.mainStackView <| .top      <| .equal <| commentCell <| .top      <| 1 <| 0
        let stackViewBottom   = ¿NSLayoutConstraint.init <| commentCell.mainStackView <| .bottom   <| .equal <| commentCell <| .bottom   <| 1 <| 0
        let stackViewLeading  = ¿NSLayoutConstraint.init <| commentCell.mainStackView <| .leading  <| .equal <| commentCell <| .leading  <| 1 <| 0
        let stackViewTrailing = ¿NSLayoutConstraint.init <| commentCell.mainStackView <| .trailing <| .equal <| commentCell <| .trailing <| 1 <| 0
        
        let stackViewConstraints = [stackViewTop, stackViewBottom, stackViewLeading, stackViewTrailing]
        
        NSLayoutConstraint.activate <| stackViewConstraints
    }
    
    // MARK: - StackView
    
    fileprivate enum StackView: Int {
        case main = 1
        
        fileprivate var stackView: UIStackView {
            let sv                                       = UIStackView()
            sv.tag                                       = rawValue
            sv.axis                                      = axis
            sv.distribution                              = distribution
            sv.alignment                                 = alignment
            sv.spacing                                   = spacing
            sv.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            return sv
        }
        
        private var axis: UILayoutConstraintAxis {
            switch self {
            case .main: return .vertical
            }
        }
        
        private var distribution: UIStackViewDistribution {
            switch self {
            case .main: return .fillProportionally
            }
        }
        
        private var alignment: UIStackViewAlignment {
            switch self {
            case .main: return .leading
            }
        }
        
        private var spacing: CGFloat {
            switch self {
            case .main: return 5
            }
        }
        
        private var translatesAutoresizingMaskIntoConstraints: Bool {
            switch self {
            case .main: return false
            }
        }
    }
    
    // MARK: - Label
    
    fileprivate enum Label: Int {
        case content = 1, author = 2
        
        fileprivate var label: UILabel {
            let l                                       = UILabel()
            l.tag                                       = rawValue
            l.backgroundColor                           = backgroundColor
            l.textColor                                 = textColor
            l.textAlignment                             = textAlignment
            l.numberOfLines                             = numberOfLines
            l.adjustsFontSizeToFitWidth                 = adjustsFontSizeToFitWidth
            l.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            return l
        }
        
        private var backgroundColor: UIColor {
            switch self {
            case .content: return .clear
            case .author:  return .red
            }
        }
        
        private var textColor: UIColor {
            switch self {
            case .content: return .white
            case .author:  return .white
            }
        }
        
        private var textAlignment: NSTextAlignment {
            switch self {
            case .content: return .left
            case .author:  return .left
            }
        }
        
        private var numberOfLines: Int {
            switch self {
            case .content: return 0
            case .author:  return 1
            }
        }
        
        private var adjustsFontSizeToFitWidth: Bool {
            switch self {
            case .content: return true
            case .author:  return false
            }
        }
        
        private var translatesAutoresizingMaskIntoConstraints: Bool {
            switch self {
            case .content: return false
            case .author:  return false
            }
        }
    }
}
