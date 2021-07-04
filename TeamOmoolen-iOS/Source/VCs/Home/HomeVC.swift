//
//  HomeVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/03.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var HomeHeaderView: UIView!
    @IBOutlet weak var HomeTableView: UITableView!
    
    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor  = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpTop), for: .touchUpInside)
        print("버튼 생성")
        return button
    }()
    
    private lazy var categoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    // MARK: - Local Variables
    
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setList()
        
        registerXib()
        setHomeTableView()
    }
}

// MARK:- Custom Methods

extension HomeVC {
    func setUI() {
        view.backgroundColor = .omAlmostwhite
        
        HomeHeaderView.backgroundColor = .white
        HomeTableView.backgroundColor = .white
        
        view.addSubview(categoryView)
        view.addSubview(topButton)
        
        categoryView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(HomeHeaderView.snp.bottom).offset(0)
        }
        
        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(-100)
        }
    }
    
    func setList() {
        
    }
    
    func registerXib() {
        let recommedNib = UINib(nibName: RecommendTVC.identifier, bundle: nil)
        HomeTableView.register(recommedNib, forCellReuseIdentifier: RecommendTVC.identifier)
        
        let oneMinNib = UINib(nibName: OneMinTVC.identifier, bundle: nil)
        HomeTableView.register(oneMinNib, forCellReuseIdentifier: OneMinTVC.identifier)
        
        let seasonNib = UINib(nibName: SeasonTVC.identifier, bundle: nil)
        HomeTableView.register(seasonNib, forCellReuseIdentifier: SeasonTVC.identifier)
    }
    
    func setHomeTableView() {
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        
        HomeTableView.separatorStyle = .none
    }
}

// MARK: - Action Methods
extension HomeVC {
    @objc
    func touchUpTop() {
        let topIndex = IndexPath(row: 0, section: 0)
        HomeTableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
}

// MARK: - UITableView Delegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 100
        case 1:
            return 300
        case 2:
            return 300
        case 3:
            return 300
        default:
            return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            print("아래로 내리는 중 ..")
            topButton.isHidden = false
            
            categoryView.snp.updateConstraints { make in
                make.height.equalTo(50)
//                make.top.equalTo(HomeHeaderView.snp.bottom).inset(30)
            }
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }
        } else {
            print("위로 올리는 중 ..")
            topButton.isHidden = true
            
            categoryView.snp.updateConstraints { make in
                make.height.equalTo(100)
//                make.top.equalTo(HomeHeaderView.snp.bottom).inset(-30)
            }
            
            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(-100)
            }
        }
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITableView DataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  RecommendTVC.identifier, for: indexPath) as? RecommendTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  OneMinTVC.identifier, for: indexPath) as? OneMinTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  SeasonTVC.identifier, for: indexPath) as? SeasonTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 3:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
