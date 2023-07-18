//
//  MyPageViewController.swift
//  AlbaReview
//
//  Created by 정지훈 on 2023/03/25.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa
import RxAppState


class MyPageViewController: UIViewController {

    //MARK: - Properties
    lazy var tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(MyPageHeaderView.self, forHeaderFooterViewReuseIdentifier: MyPageHeaderView.identifier)
        $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        $0.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.identifier)
        $0.register(AlbaCell.self, forCellReuseIdentifier: AlbaCell.identifier)
        $0.register(OtherCell.self, forCellReuseIdentifier: OtherCell.identifier)
    }
    
    var datasource: UITableViewDiffableDataSource<MyPageSection, MyPageSectionItem>!
    let viewModel = MyPageViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setAddView()
        setConstraints()
        configureDataSource()
        bind()
    }
    
    //MARK: - SetUp
    private func setUpUI() {
        tableView.separatorStyle = .none
        view.backgroundColor = .white
    }
    
    private func setAddView() {
        [
            tableView
        ]   .forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func bind() {
        
        rx.viewWillAppear
            .take(1)
            .bind(onNext: { _ in
                self.viewModel.setUpSections()
            }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.sectionsSubject
            .bind(onNext: { sections in
                var snapshot = NSDiffableDataSourceSnapshot<MyPageSection, MyPageSectionItem>()
                snapshot.appendSections(sections)
                
                sections.forEach { section in
                    snapshot.appendItems(section.items, toSection: section)
                }
                
                DispatchQueue.main.async {
                    self.datasource.apply(snapshot)
                }
            }).disposed(by: disposeBag)
    }
    
    private func configureDataSource() {
        datasource = UITableViewDiffableDataSource<MyPageSection, MyPageSectionItem>(tableView: tableView, cellProvider: { tableView, indexPath, item in
            switch item {
            case .profile(let profile):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.nicknameLabel.text = profile.nickname
                cell.sexAgeLabel.text = profile.sexAndAge
                return cell
            case .accountCell(let title):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCell.identifier, for: indexPath) as? MyPageCell else { return UITableViewCell() }
                
                cell.titleLabel.text = title
                return cell
            case .albaCell(let title):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbaCell.identifier, for: indexPath) as? AlbaCell else { return UITableViewCell() }
                
                cell.titleLabel.text = title
                return cell
            case .otherCell(let title):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherCell.identifier, for: indexPath) as? OtherCell else { return UITableViewCell() }
                
                cell.titleLabel.text = title
                return cell
            }
        })
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 110
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 0 { return UIView() }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageHeaderView.identifier) as? MyPageHeaderView else { return UIView() }
        
        header.headerLabel.text = viewModel.headers[section - 1]
        
        return header
    }
}
