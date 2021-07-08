//
//  SearchInTVC.swift
//  TeamOmoolen-iOS
//
//  Created by kyoungjin on 2021/07/06.
//
import Foundation
import UIKit
import RealmSwift

class SearchInTVC: UITableViewCell {

    static let identifier = "SearchInTVC"
    
    //Mark: - IB Outlets
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    //Mark: - Variables
    var enteredText: String?
    var realm: Realm?
    var searchList: Array<String> = []
    var resultArray: Array<String> = []

    //Mark: - Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        realm = try? Realm()
        registerXib()
        setSearchList()
        setSearchHistoryTable()
        checkNotification()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Mark: - objc Methods
    @objc func removeWord(notification: NSNotification){
        if let word = notification.object as? String {
            do {
                removeFromRealm(target: word)
                searchHistoryTableView.reloadData()
                print(searchList)
            } catch  {
                print("지워지지 않았습니다")
            }
        }
    }
    
    @objc func allClear() {
        if (searchList.count == 0) {
            print("지울 단어가 없어요")
        }
        do {
            try! realm?.write {
                realm?.deleteAll()
                searchList.removeAll()
                searchList.removeAll()
                searchHistoryTableView.reloadData()
                
            }
        } catch {
            print("지워지지 않았습니다" )
        }
    }
    
    //Mark: - Methods
    func registerXib() {
        let SearchInNib = UINib(nibName: SearchInTVC.identifier, bundle: nil)
        
        let SearchWordNib = UINib(nibName: SearchWordTVC.identifier, bundle: nil)
        let NoRecentNib = UINib(nibName: NoRecentTVC.identifier, bundle: nil)
        let AllClearNib = UINib(nibName: AllClearTVC.identifier, bundle: nil)
        
        searchHistoryTableView.register(SearchWordNib, forCellReuseIdentifier: SearchWordTVC.identifier)
        searchHistoryTableView.register(NoRecentNib, forCellReuseIdentifier: NoRecentTVC.identifier)
        searchHistoryTableView.register(AllClearNib, forCellReuseIdentifier: AllClearTVC.identifier)
    }
    
    func setSearchList(){
        let savedWords = realm?.objects(RecentSearch.self)
        let Results: Results<RecentSearch> = (savedWords)!
        let ResultArray = Results.toArray()
        
        if (ResultArray.count == 0) {
            return
        } else if (ResultArray.count == 1){
            searchList.append(ResultArray[ResultArray.count-1].word)
        } else if (ResultArray.count == 2){
            searchList.append(ResultArray[ResultArray.count-1].word)
            searchList.append(ResultArray[ResultArray.count-2].word)
        } else {
            searchList.append(ResultArray[ResultArray.count-1].word)
            searchList.append(ResultArray[ResultArray.count-2].word)
            searchList.append(ResultArray[ResultArray.count-3].word)
        }
    }
    
    func setSearchHistoryTable() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.separatorStyle = .none
    }
   
    func checkNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchEntered), name: NSNotification.Name("search"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeWord), name: NSNotification.Name("RemoveWord"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(allClear), name: NSNotification.Name("AllClear"), object: nil)
    }
    
    @objc func searchEntered(notification: NSNotification) {
        let enteredText = notification.object as! String
    
        if enteredText.isEmpty {
            print("검색어를 입력해 주세요")
        }
        do {
            try realm!.write {
                let searchWord = RecentSearch()
                searchWord.word = enteredText
                if (realm?.objects(RecentSearch.self).count == 0) {
                    //처음 입력 받았을때
                    realm?.add(searchWord)
                    print("검색어를 입력해 주세요")
                }
                else if (searchList.contains(searchWord.word)) {
                    print("db 추가할 필요 없음")
                } else {
                    realm?.add(searchWord)
                }
            }
        } catch {
            print("문제")
        }
    }
    
    func inputData(database: RecentSearch) -> RecentSearch {
        if let text = enteredText {
            database.word = text
        }
        return database
    }
    
    func removeFromRealm(target: String) {
            let targetWord = realm?.objects(RecentSearch.self).filter("word CONTAINS[c] %@", target)
            try! realm?.write {
                if let obj = targetWord {
                    //db에서 지워주기
                    realm?.delete(obj)
                    let idx = searchList.firstIndex(of: target)!
                    searchList.remove(at: idx)
                }
            }
    }
}

//Mark: - Extensions
extension Results {
    func toArray() -> Array<Element> {
        return self.map{$0}
    }
}

extension SearchInTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (searchList.count == 0) {
            switch indexPath.section {
            case 0:
                return 80 //최근검색어 없음
            case 1:
                return 48 //전체삭제
            default:
                return 50 //나중에 변경
            }
        } else if (searchList.count == 1) {
            switch indexPath.section {
            case 0:
                return 50 //단어 1
            case 1:
                return 48 //전체삭제
            default:
                return 50
            }
        } else if (searchList.count == 2) {
            switch indexPath.section {
            case 0:
                return 50 //단어 1
            case 1:
                return 50 //단어 2
            case 2:
                return 48 //전체삭제
            default:
                return 50
            }
        } else {
            //검색어 세개 다 꽉 찬 경우
            switch indexPath.section {
            case 0:
                return 50
            case 1:
                return 50
            case 2:
                return 50
            case 3:
                return 48
            default:
                return 50
            }
        }
    }
}


extension SearchInTVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (searchList.count == 0){ //검색어 3개에서 전체 삭제 했을 때 여기로 들어옴
            tableViewWidth.constant = 129
            return 2
        } else if (searchList.count == 1){
            tableViewWidth.constant = 125
            return 2
        } else if (searchList.count == 2){
            tableViewWidth.constant = 164
            return 3
        }
            tableViewWidth.constant = 225
            return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (searchList.count == 0) {
            switch indexPath.section {
            case 0: //최근검색어 없음
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  NoRecentTVC.identifier, for: indexPath) as? NoRecentTVC else {
                    return UITableViewCell()
                }
                return cell
            case 1: //전체삭제 버튼
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        } else if (searchList.count == 1) {
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[0]
                return cell
            case 1: //전체삭제 버튼
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        } else if (searchList.count == 2){
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[0]
                return cell

            case 1: //단어 2
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[1]
                return cell
            
            case 2: //전체삭제
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? AllClearTVC else {
                    return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        } //3개 이상일 경우
            switch indexPath.section {
            case 0: //단어 1
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[0]
                return cell
            
            case 1: //단어 2
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[1]
                return cell
                
            case 2: //단어 3
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchWordTVC.identifier, for: indexPath) as? SearchWordTVC else {
                    return UITableViewCell()
                }
                cell.searchLabel.text = searchList[2]
                return cell
                
            case 3: //전체삭제
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AllClearTVC.identifier, for: indexPath) as? SearchWordTVC else {
                return UITableViewCell()
                }
                return cell
            default:
                return UITableViewCell()
            }
        }
}
