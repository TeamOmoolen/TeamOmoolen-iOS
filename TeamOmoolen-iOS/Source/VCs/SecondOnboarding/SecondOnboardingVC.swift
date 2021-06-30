//
//  SecondOnboardingVC.swift
//  TeamOmoolen-iOS
//
//  Created by kimhyungyu on 2021/06/30.
//

import UIKit

class SecondOnboardingVC: UIViewController {
    // MARK: - Properties
    private var lensKindList = [LensKindModel]()
    private var lensColorList = [LensColorModel]()

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var progressStatusLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstCollectionView: UICollectionView!
    @IBOutlet weak var firstSubtitleLabel: UILabel!
    @IBOutlet weak var secondCollectionView: UICollectionView!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondSubtitleLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setList()
        collectionViewDelegate()
        registerXib()
        

        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgressViewWithAnimation), userInfo: nil, repeats: true)
    }
    // MARK: - Methods
    func setUI() {
        progressView.progress = 0.25
        progressView.progressTintColor = .orange
        
        progressStatusLabel.text = "2/4"
        
        firstTitleLabel.text = "어떤 렌즈가 필요하세요?"
        firstTitleLabel.textColor = .black
        firstSubtitleLabel.text = "렌즈를 선택하시면 취향에 맞게 렌즈를 추천해드릴게요!"
        firstSubtitleLabel.textColor = .systemGray
        
        secondTitleLabel.text = "좋아하는 렌즈 색상은 무엇인가요?"
        secondTitleLabel.textColor = .black
        
        secondSubtitleLabel.text = "중복선택이 가능해요!"
        secondSubtitleLabel.textColor = .systemGray
    }
    
    func collectionViewDelegate() {
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
    }
    
    func registerXib() {
        let firstNib = UINib(nibName: "LensKindCVC", bundle: nil)
        firstCollectionView.register(firstNib, forCellWithReuseIdentifier: "LensKindCVC")
        
        let secondNib = UINib(nibName: "LensColorCVC", bundle: nil)
        secondCollectionView.register(secondNib, forCellWithReuseIdentifier: "LensColorCVC")
    }
    
    func setList() {
        lensKindList.append(contentsOf: [
        LensKindModel(image: "abc", title: "컬러렌즈"),
            LensKindModel(image: "abc", title: "투명렌즈"),
            LensKindModel(image: "abc", title: "코스프레/공막렌즈"),
        ])
        
        lensColorList.append(contentsOf: [
            LensColorModel(color: .systemRed, title: "빨강"),
            LensColorModel(color: .systemBlue, title: "파랑"),
            LensColorModel(color: .systemPink, title: "분홍")
        ])
    }

    // MARK: - @objc Methods
    @objc func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 1) {
            if self.progressView.progress != 0.5 {
                self.progressView.setProgress(0.5, animated: true)
            }
        }
    }
    
    // MARK: - @IBAction Properties
    
}

// MARK: - UICollectionViewDelegate
extension SecondOnboardingVC: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension SecondOnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return lensKindList.count
        } else if collectionView == secondCollectionView {
            return lensColorList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            guard let firstCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LensKindCVC", for: indexPath) as? LensKindCVC else {
                return UICollectionViewCell()
            }
            firstCell.initCell(image: lensKindList[indexPath.row].image, title: lensKindList[indexPath.row].title)
            
            return firstCell
        } else if collectionView == secondCollectionView {
            guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LensColorCVC", for: indexPath) as? LensColorCVC else {
                return UICollectionViewCell()
            }
            secondCell.initCell(color: lensColorList[indexPath.row].color, title: lensColorList[indexPath.row].title)
            
            return secondCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}
// MARK: - UICollectionViewDelegateFlowLayout
extension SecondOnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == firstCollectionView {
            return CGSize(width: 160, height: 160)
        } else {
            return CGSize(width: 164, height: 60)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == firstCollectionView {
            return 11
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == firstCollectionView {
            return 11
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
