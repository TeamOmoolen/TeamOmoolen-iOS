//
//  LeftAlignedCVFlowLayout.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/01.
//
import Foundation
import UIKit

class LeftAlignedCVFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left + 2 //여기서 간격을 바꿨습니다
            }
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
            
        }
        return attributes
    }
}
