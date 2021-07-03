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
    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBar()
        setList()
        collectionViewDelegate()
        registerXib()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation()
        }
    }
    // MARK: - Methods
    func setUI() {
        backScrollView.backgroundColor = .omAlmostwhite
        backView.backgroundColor = .omAlmostwhite
        firstCollectionView.backgroundColor = .omAlmostwhite
        secondCollectionView.backgroundColor = .omAlmostwhite
        
        progressView.progress = 0.25
        progressView.progressTintColor = .omMainOrange
        
        progressStatusLabel.text = "2/4"
        progressStatusLabel.font = UIFont(name: "Roboto-Regular", size: 12)
        progressStatusLabel.textColor = .omThirdGray
        
        firstTitleLabel.text = "어떤 렌즈가 필요하세요?"
        firstTitleLabel.textColor = .omMainBlack
        firstTitleLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        firstSubtitleLabel.text = "렌즈를 선택하시면 취향에 맞게 렌즈를 추천해드릴게요!"
        firstSubtitleLabel.textColor = .omFourthGray
        firstSubtitleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        secondTitleLabel.text = "좋아하는 렌즈 색상은 무엇인가요?"
        secondTitleLabel.textColor = .omMainBlack
        secondTitleLabel.font = UIFont(name: "NotoSansCJKKR-Bold", size: 18)
        
        secondSubtitleLabel.text = "중복선택이 가능해요!"
        secondSubtitleLabel.textColor = .omFourthGray
        secondSubtitleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 18)
        nextButton.tintColor = .omWhite
        nextButton.backgroundColor = .omFourthGray
        nextButton.layer.cornerRadius = 10
        nextButton.isUserInteractionEnabled = false
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "맞춤 정보 설정"
        self.navigationController?.navigationBar.tintColor = .omSecondGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.omSecondGray, .font: UIFont(name: "NotoSansCJKKR-Medium", size: 16) as Any]
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "icBack")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "icBack")
        self.navigationItem.backButtonTitle = ""
    }
    
    func collectionViewDelegate() {
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.allowsMultipleSelection = true
    }
    
    func registerXib() {
        let firstNib = UINib(nibName: "LensKindCVC", bundle: nil)
        firstCollectionView.register(firstNib, forCellWithReuseIdentifier: "LensKindCVC")
        
        let secondNib = UINib(nibName: "LensColorCVC", bundle: nil)
        secondCollectionView.register(secondNib, forCellWithReuseIdentifier: "LensColorCVC")
    }
    
    func setList() {
        lensKindList.append(contentsOf: [
        LensKindModel(image: "imgColorlens", title: "컬러렌즈"),
            LensKindModel(image: "imgTrans", title: "투명렌즈"),
            LensKindModel(image: "imgCoslens", title: "코스프레/공막렌즈"),
        ])
        
        lensColorList.append(contentsOf: [
            LensColorModel(image: "btnNoncolor"),
            LensColorModel(image: "btnBlackcolor"),
            LensColorModel(image: "btnGreycolor"),
            LensColorModel(image: "btnChococolor"),
            LensColorModel(image: "btnGreencolor"),
            LensColorModel(image: "btnBrowncolor"),
            LensColorModel(image: "btnPurplecolor"),
            LensColorModel(image: "btnBluecolor"),
            LensColorModel(image: "btnGoldcolor"),
            LensColorModel(image: "btnPinkcolor"),
            LensColorModel(image: "btnGlittercolor"),
            LensColorModel(image: "btnEtccolor")
        ])
    }
    
    func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.5 {
                self.progressView.setProgress(0.5, animated: true)
            }
        }
    }
    
    // MARK: - @IBAction Properties
    @IBAction func pushToThirdOnboarding(_ sender: Any) {
        print(firstCollectionView.indexPathsForSelectedItems!)
        print(secondCollectionView.indexPathsForSelectedItems!)
        
        guard let nextVC = UIStoryboard(name: Const.Storyboard.Name.ThirdOnboarding, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.ThirdOnboarding) as? ThirdOnboardingVC else {
            return
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate
extension SecondOnboardingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if firstCollectionView.indexPathsForSelectedItems?.isEmpty == false && secondCollectionView.indexPathsForSelectedItems?.isEmpty == false {
            nextButton.backgroundColor = .omMainOrange
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .omFourthGray
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if firstCollectionView.indexPathsForSelectedItems?.isEmpty == false && secondCollectionView.indexPathsForSelectedItems?.isEmpty == false {
            nextButton.backgroundColor = .omMainOrange
            nextButton.isUserInteractionEnabled = true
        } else {
            nextButton.backgroundColor = .omFourthGray
            nextButton.isUserInteractionEnabled = false
        }
    }
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
            
            firstCell.layer.applyShadow(color: .black, alpha: 0.14, x: 2, y: 2, blur: 7, spread: 0)
            firstCell.contentView.layer.cornerRadius = 20
            firstCell.contentView.layer.masksToBounds = true
            
            return firstCell
        } else if collectionView == secondCollectionView {
            guard let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LensColorCVC", for: indexPath) as? LensColorCVC else {
                return UICollectionViewCell()
            }
            secondCell.initCell(image: lensColorList[indexPath.row].image)
            
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
            let width = collectionView.frame.width
            let cellWidth = (width - 20) / 2
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            let width = collectionView.frame.width
            let height = collectionView.frame.height
            let cellWidth = (width - 6) / 2
            let cellHeight = (height - 40) / 6
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == firstCollectionView {
            return 10
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == firstCollectionView {
            return 10
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == firstCollectionView {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        } else {
            return .zero
        }
    }
}
