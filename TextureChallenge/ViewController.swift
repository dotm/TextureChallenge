//
//  ViewController.swift
//  TextureChallenge
//
//  Created by Nakama on 12/04/19.
//  Copyright © 2019 Nakama. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: ASViewController<ASDisplayNode> {
    private let rootNode = ASDisplayNode()
    private let article = ArticleNode()
    public init() {
        rootNode.backgroundColor = .white
        rootNode.addSubnode(article)
        super.init(node: rootNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLayoutSubviews() {
        rootNode.frame = UIScreen.main.bounds
        article.frame = UIApplication.shared.keyWindow?.safeAreaLayoutGuide.layoutFrame ?? CGRect.zero
    }
}

class ArticleNode: ASDisplayNode {
    private let titleNode = ArticleTitleNode()
    private let articlePhotos = ArticlePhotosRowNode()
    private let shopLink = ArticleVisitShopLinkNode()
    private let articleDescription = ArticleDescription()
    private let footer = ArticleFooterNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .purple
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let titleSpec = ASInsetLayoutSpec(insets: padding, child: titleNode)
        let shopLinkSpec = ASInsetLayoutSpec(insets: padding, child: shopLink)
        let articleDescriptionSpec = ASInsetLayoutSpec(insets: padding, child: articleDescription)
        let stackSpec = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleSpec, self.articlePhotos, shopLinkSpec, articleDescriptionSpec, footer]
        )
        
        return stackSpec
    }
}

class ArticleFooterNode: ASDisplayNode {
    private let likeNode = LikeNode()
    private let commentNode = CommentNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .brown
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceAround,
            alignItems: .start,
            children: [likeNode,commentNode]
        )
        return stack
    }
}

class CommentNode: ASDisplayNode {
    private let commentIconNode = ASImageNode()
    private let commentCountNode = ASTextNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .cyan
        
        commentIconNode.image = UIImage(named: "comment")
        commentCountNode.attributedText = NSAttributedString(string: "2", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        commentIconNode.style.preferredSize = CGSize(width: 24, height: 24)
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .center,
            alignItems: .center,
            children: [commentIconNode,commentCountNode]
        )
    }
}
class LikeNode: ASDisplayNode {
    private let likeIconNode = ASImageNode()
    private let likeCountNode = ASTextNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .cyan
        
        likeIconNode.image = UIImage(named: "like")
        likeCountNode.attributedText = NSAttributedString(string: "106", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        likeIconNode.style.preferredSize = CGSize(width: 24, height: 24)
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .center,
            alignItems: .center,
            children: [likeIconNode,likeCountNode]
        )
    }
}

class ArticleDescription: ASTextNode {
    override init() {
        super.init()
        let description = "Touched down Bangkok and all ready for tonight's dinner with @michaelkors in everything #MichaelKors #MKBKK #travelwithanaz"
        self.attributedText = NSAttributedString(string: description, attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
    }
}

class ArticleVisitShopLinkNode: ASDisplayNode {
    private let cityNameTextNode = ASTextNode()
    private let nextButtonTextNode = ASTextNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = UIColor(red: 0.5, green: 1, blue: 0.5, alpha: 1)
        
        cityNameTextNode.attributedText = NSAttributedString(string: "Kunjungi Toko", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
        cityNameTextNode.backgroundColor = .cyan
        
        nextButtonTextNode.attributedText = NSAttributedString(string: ">", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
        nextButtonTextNode.backgroundColor = .cyan
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [cityNameTextNode, nextButtonTextNode]
        )
    }
}

class ArticlePhotosRowNode: ASDisplayNode {
    private let firstPhoto = ASDisplayNode()
    private let secondPhoto = ASDisplayNode()
    private let thirdPhoto = ASDisplayNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .black
        
        firstPhoto.backgroundColor = .red
        secondPhoto.backgroundColor = .green
        thirdPhoto.backgroundColor = .blue
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.style.maxWidth = ASDimension(unit: .points, value: constrainedSize.max.width)
        
        let preferredSize = CGSize(width: 100, height: 100)
        firstPhoto.style.preferredSize = preferredSize
        secondPhoto.style.preferredSize = preferredSize
        thirdPhoto.style.preferredSize = preferredSize
        firstPhoto.style.flexGrow = CGFloat(1.0)
        secondPhoto.style.flexGrow = CGFloat(1.0)
        thirdPhoto.style.flexGrow = CGFloat(1.0)
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .spaceBetween,
            alignItems: .stretch,
            children: [firstPhoto, secondPhoto, thirdPhoto]
        )
    }
}

class ArticleTitleNode: ASDisplayNode {
    private let profileImageNode = ASDisplayNode()
    private let profileNameTextNode = ASTextNode()
    private let categoryNameTextNode = ASTextNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .yellow
        
        profileImageNode.backgroundColor = .black
        
        profileNameTextNode.attributedText = NSAttributedString(string: "Anas Ziantar", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
        profileNameTextNode.backgroundColor = .cyan
        categoryNameTextNode.attributedText = NSAttributedString(string: "Fashion Wanita", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 24)
            ]
        )
        categoryNameTextNode.backgroundColor = .cyan
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        profileImageNode.style.preferredSize = CGSize(width: CGFloat(75), height: CGFloat(75))
        
        let rightSideLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .center,
            alignItems: .start,
            children: [profileNameTextNode,categoryNameTextNode]
        )
        let horizontalLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .start,
            alignItems: .stretch,
            children: [self.profileImageNode, rightSideLayout]
        )
        
        return horizontalLayout
    }
}
