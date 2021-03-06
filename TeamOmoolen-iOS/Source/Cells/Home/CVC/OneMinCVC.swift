//
//  OneMinCVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/05.
//

import UIKit

class OneMinCVC: UICollectionViewCell {
    static let identifier = "OneMinCVC"
    
    // MARK: - UI Components
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var oneMinTableView: UITableView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Local Variables
    
    private var oneMinDetailData = [OneMinDetailDataModel]()
    var delegate: ViewModalProtocol?
    
    var title: String = ""
    var guideDetail = [Guide]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        registerXib()
        setTableView()
    }
}

extension OneMinCVC {
    func setUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.omFifthGray.cgColor
        contentView.layer.masksToBounds = true
        
        topView.backgroundColor = .omMainOrange
        
        oneMinTableView.backgroundColor = .gray
        
        titleLabel.text = "오무렌 1분 렌즈 상식"
        titleLabel.font = UIFont(name: "NotoSansCJKKR-Regular", size: 13)
        titleLabel.textColor = .omAlmostwhite
        
        subtitleLabel.text = "나에게 맞는 렌즈, 어떻게 사?"
        subtitleLabel.font = UIFont(name: "NotoSansCJKKR-Medium", size: 17)
        subtitleLabel.textColor = .white
        
        moreButton.setTitle("1분 렌즈 상식 더보기", for: .normal)
        moreButton.tintColor = .omSecondGray
        moreButton.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Regular", size: 14)
        moreButton.backgroundColor = .omFifthGray
        moreButton.layer.cornerRadius = 10
        moreButton.layer.masksToBounds = true
    }
    
    func initCell(subTitle: String, oneMinDetail: [Guide]) {
        subtitleLabel.text = subTitle
        guideDetail = oneMinDetail
        
        oneMinTableView.reloadData()
    }
    
    func initImage(idx: Int, imageName: String) {
        if idx == 0 {
            topView.backgroundColor = .omMainOrange
        } else if idx == 1 {
            topView.backgroundColor = .omPurple
        } else {
            topView.backgroundColor = .omMainGreen
        }
        imageView.image = UIImage(named: imageName)
    }
    
    func registerXib() {
        let nib = UINib(nibName: OneMinDetailTVC.identifier, bundle: nil)
        oneMinTableView.register(nib, forCellReuseIdentifier: OneMinDetailTVC.identifier)
    }
    
    func setTableView() {
        oneMinTableView.backgroundColor = .white
        
        oneMinTableView.delegate = self
        oneMinTableView.dataSource = self
        
        oneMinTableView.isScrollEnabled = false
    }
}

extension OneMinCVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension OneMinCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guideDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OneMinDetailTVC.identifier) as? OneMinDetailTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.initCell(title: guideDetail[indexPath.row].question, subTitle: guideDetail[indexPath.row].answer)
        return cell
    }
}
