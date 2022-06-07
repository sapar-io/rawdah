//
//  HomeViewController.swift
//  99Names
//
//  Created by Sapar Jumabekov on 27.05.2022.
//

import UIKit
import Stevia

class HomeViewController: UIViewController {
    
    // MARK: - Model
    private enum Content {
        case topics
        case names
    }
    
    // MARK: - Variables
    private var currentContent: Content = .topics
    private let realm = RealmDB()
    private var learnedNames = [LearnedName]()
    private var passedQuizes = [PassedQuiz]()
    private var learnedNamesInTopic = [Int: Int]()
    
    // MARK: - Outlets
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        learnedNames = realm.learnedNames()
        passedQuizes = realm.passedQuizes()
        calculateTopicPercentages()
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func calculateTopicPercentages() {
        learnedNamesInTopic = [:]
        learnedNames.forEach {
            switch $0.id {
            case 0...9:
                learnedNamesInTopic[0] = (learnedNamesInTopic[0] ?? 0) + 1
            case 10...18:
                learnedNamesInTopic[1] = (learnedNamesInTopic[1] ?? 0) + 1
            case 19...27:
                learnedNamesInTopic[2] = (learnedNamesInTopic[2] ?? 0) + 1
            case 28...36:
                learnedNamesInTopic[3] = (learnedNamesInTopic[3] ?? 0) + 1
            case 37...45:
                learnedNamesInTopic[4] = (learnedNamesInTopic[4] ?? 0) + 1
            case 46...54:
                learnedNamesInTopic[5] = (learnedNamesInTopic[5] ?? 0) + 1
            case 55...63:
                learnedNamesInTopic[6] = (learnedNamesInTopic[6] ?? 0) + 1
            case 64...72:
                learnedNamesInTopic[7] = (learnedNamesInTopic[7] ?? 0) + 1
            case 73...81:
                learnedNamesInTopic[8] = (learnedNamesInTopic[8] ?? 0) + 1
            case 82...90:
                learnedNamesInTopic[9] = (learnedNamesInTopic[9] ?? 0) + 1
            case 91...99:
                learnedNamesInTopic[10] = (learnedNamesInTopic[10] ?? 0) + 1
            default:
                fatalError("calculateTopicPercentages")
            }
        }
        
        passedQuizes.forEach {
            switch $0.id {
            case 1:
                learnedNamesInTopic[0] = (learnedNamesInTopic[0] ?? 0) + 1
            case 2:
                learnedNamesInTopic[1] = (learnedNamesInTopic[1] ?? 0) + 1
            case 3:
                learnedNamesInTopic[2] = (learnedNamesInTopic[2] ?? 0) + 1
            case 4:
                learnedNamesInTopic[3] = (learnedNamesInTopic[3] ?? 0) + 1
            case 5:
                learnedNamesInTopic[4] = (learnedNamesInTopic[4] ?? 0) + 1
            case 6:
                learnedNamesInTopic[5] = (learnedNamesInTopic[5] ?? 0) + 1
            case 7:
                learnedNamesInTopic[6] = (learnedNamesInTopic[6] ?? 0) + 1
            case 8:
                learnedNamesInTopic[7] = (learnedNamesInTopic[7] ?? 0) + 1
            case 9:
                learnedNamesInTopic[8] = (learnedNamesInTopic[8] ?? 0) + 1
            case 10:
                learnedNamesInTopic[9] = (learnedNamesInTopic[9] ?? 0) + 1
            case 11:
                learnedNamesInTopic[10] = (learnedNamesInTopic[10] ?? 0) + 1
            default:
                fatalError("calculateTopicPercentages")
            }
        }
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc private func changeContentTapped() {
        currentContent = currentContent == .topics ? .names : .topics
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: currentContent == .topics ? "list.number" : "folder"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(changeContentTapped))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        tableView.reloadData()
    }
    
    @objc private func settingDidTapped() {
        let vc = UINavigationController(rootViewController: SettingsViewController())
        navigationController?.present(vc, animated: true)
    }
}

// MARK: - Setups
extension HomeViewController {
    private func setup() {
        navigationItem.title = "99 имен Аллаха"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:  "list.number"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(changeContentTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(settingDidTapped))
        TopicCell.register(for: tableView)
        NameCell.register(for: tableView)
        SponserCell.register(for: tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.subviews(tableView)
        tableView.Top == view.safeAreaLayoutGuide.Top
        tableView.fillHorizontally().bottom(0)
    }
}

// MARK: - CollectionView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lenght = currentContent == .topics ? 11 : 99
        return lenght + 1 // add for footer sponser one cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let maxLenght = currentContent == .topics ? 11 : 99
        
        if maxLenght == indexPath.row {
            
            // if its last cell
            return SponserCell.dequeue(tableView, for: indexPath)
            
        } else if currentContent == .topics {
            
            let learnedInTopic = learnedNamesInTopic[indexPath.row] ?? 0
            let percentage = learnedInTopic * 100 / 10
            
            let cell = TopicCell.dequeue(tableView, for: indexPath)
            cell.configure(id: indexPath.row, percentage: percentage)
            return cell
            
        } else {
            
            let cell = NameCell.dequeue(tableView, for: indexPath)
            cell.configure(name: AllNames[indexPath.row], isLearned: learnedNames.contains(where: { $0.id == indexPath.row + 1 }))
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let maxLenght = currentContent == .topics ? 11 : 99
        
        if maxLenght == indexPath.row {
            return
        } else if currentContent == .topics {
            let vc = TopicViewController(id: indexPath.row)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let name = AllNames[indexPath.row]
            let vc = LessonViewController(name: name)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
