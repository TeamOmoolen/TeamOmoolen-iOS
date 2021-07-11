//
//  DetailVC.swift
//  TeamOmoolen-iOS
//
//  Created by soyeon on 2021/07/08.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - UI Components
    
    @IBOutlet weak var detailTableView: UITableView!
    
    private lazy var writeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icWrite"), for: .normal)
        return button
    }()
    
    // MARK: - Local Variables
    
    private var lensData = [DetailDataModel]()
    private var mainData = [DetailMainDataModel]()
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setData()
        
        registerXib()
        setTableView()
        
        setTabbarController()
        setNavigationController()
    }
}

extension DetailVC {
    func setUI() {
        view.addSubview(writeButton)
        
        writeButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(700)
        }
    }
    
    func setData() {
        mainData.append(contentsOf: [
            DetailMainDataModel(brandName: "오렌즈", lensName: "브라운 컬러 렌즈", price: 18000, diameter: 13.5, cycle: 30, texture: "실리콘 하이드로겔", function: "난시", colorList: [888888, 111111])
        ])
    }
    
    func registerXib() {
        let topNib = UINib(nibName: DetailTopTVC.identifier, bundle: nil)
        detailTableView.register(topNib, forCellReuseIdentifier: DetailTopTVC.identifier)
        
        let reviewNib = UINib(nibName: ReviewTVC.identifier, bundle: nil)
        detailTableView.register(reviewNib, forCellReuseIdentifier: ReviewTVC.identifier)
        
        let similarNib = UINib(nibName: DetailSimilarTVC.identifier, bundle: nil)
        detailTableView.register(similarNib, forCellReuseIdentifier: DetailSimilarTVC.identifier)
        
        let newNib = UINib(nibName: DetailNewTVC.identifier, bundle: nil)
        detailTableView.register(newNib, forCellReuseIdentifier: DetailNewTVC.identifier)
    }
    
    func setTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        detailTableView.separatorStyle = .none
    }
    
    func setTabbarController() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func setNavigationController() {
        navigationController?.navigationBar.isHidden = false
    }
}

extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 838
        case 1:
            return 1315
        case 2:
            return 756
        case 3:
            return 650
        default:
            return UITableView.automaticDimension
        }
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTopTVC.identifier) as? DetailTopTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            cell.initCell(brand: mainData[indexPath.row].brandName, lens: mainData[indexPath.row].lensName, price: mainData[indexPath.row].price, diameter: mainData[indexPath.row].diameter, cycle: mainData[indexPath.row].cycle, function: mainData[indexPath.row].function, colorList: mainData[indexPath.row].colorList)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTVC.identifier) as? ReviewTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailSimilarTVC.identifier) as? DetailSimilarTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailNewTVC.identifier) as? DetailNewTVC else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Protocol

extension DetailVC: ViewModalProtocol {
    func detailViewModalDelegate(dvc: DetailVC) {
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    func suggestViewModalDelegate(dvc: SuggestVC) {
        navigationController?.pushViewController(dvc, animated: true)
    }
}
