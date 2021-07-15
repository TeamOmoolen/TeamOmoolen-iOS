//
//  LastBannerTVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class LastBannerTVC: UITableViewCell {
    static let identifier = "LastBannerTVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var firstIndicator: UIView!
    @IBOutlet weak var secondIndicator: UIView!
    @IBOutlet weak var thirdIndicator: UIView!
    
    // MARK: - Local Variables
    var event: [Event]?
    private var imageList = [String]()
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        setList()
        
        registerXib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension LastBannerTVC {
    func setUI() {
        collectionView.backgroundColor = .omWhite
        
        firstIndicator.backgroundColor = .omMainOrange
        firstIndicator.layer.cornerRadius = 2
        firstIndicator.layer.masksToBounds = true
        
        secondIndicator.backgroundColor = .omWhite
        secondIndicator.layer.cornerRadius = 2
        secondIndicator.layer.masksToBounds = true
        
        thirdIndicator.backgroundColor = .omWhite
        thirdIndicator.layer.cornerRadius = 2
        thirdIndicator.layer.masksToBounds = true
    }
    
    func setList() {
        imageList.append(event?[0].image ?? "")
        imageList.append(event?[1].image ?? "")
        imageList.append(event?[2].image ?? "")
    }
    
    func registerXib() {
        let nib = UINib(nibName: BannerCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BannerCVC.identifier)
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func initCell(ImageList: [Event]) {
        self.event = ImageList
        collectionView.reloadData()
    }
}

extension LastBannerTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = contentView.frame.width
        let height = contentView.frame.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let spacing = contentView.frame.width
        var offset = targetContentOffset.pointee
        let index = round((offset.x + scrollView.contentInset.left) / spacing)

        offset = CGPoint(x: index * spacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        if index == 0{
            firstIndicator.backgroundColor = .omMainOrange
            secondIndicator.backgroundColor = .omWhite
            thirdIndicator.backgroundColor = .omWhite
        } else if index == 1 {
            firstIndicator.backgroundColor = .omWhite
            secondIndicator.backgroundColor = .omMainOrange
            thirdIndicator.backgroundColor = .omWhite
        } else {
            firstIndicator.backgroundColor = .omWhite
            secondIndicator.backgroundColor = .omWhite
            thirdIndicator.backgroundColor = .omMainOrange
        }
    }
}

extension LastBannerTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVC.identifier, for: indexPath) as? BannerCVC else {
            return UICollectionViewCell()
        }
        cell.initCell(image: event?[indexPath.row].image ?? "")
        return cell
    }
}

