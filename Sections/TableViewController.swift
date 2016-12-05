//
//  ViewController.swift
//  Sections
//
//  Created by luojie on 2016/12/5.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import BNKit
import RxSwift
import RxCocoa
import RxDataSources

class TableViewController: UITableViewController {

    typealias Section = SectionModel<SectionStyle, CellStyle>
    var sections = [Section]() {
        didSet { tableView.reloadData() }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData() {
        sections = [
            SectionModel(model: SectionStyle.basicSection, items: [
                .basic("basic 0"),
                .basic("basic 1"),
                .basic("basic 2"),
                ]),
            SectionModel(model: SectionStyle.rightDetailSection, items: [
                .rightDetail(title: "rightDetail 0", subtitle: "Detail 0"),
                .rightDetail(title: "rightDetail 1", subtitle: "Detail 1"),
                .rightDetail(title: "rightDetail 2", subtitle: "Detail 2"),
                ]),
            SectionModel(model: SectionStyle.leftDetailSection, items: [
                .leftDetail(title: "leftDetail 0", subtitle: "Detail 0"),
                .leftDetail(title: "leftDetail 1", subtitle: "Detail 1"),
                .leftDetail(title: "leftDetail 2", subtitle: "Detail 2"),
                ]),
            SectionModel(model: SectionStyle.subtitleSection, items: [
                .subtitle(title: "subtitle 0", subtitle: "Detail 0"),
                .subtitle(title: "subtitle 1", subtitle: "Detail 1"),
                .subtitle(title: "subtitle 2", subtitle: "Detail 2"),
                ]),
        ]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].items[indexPath.row] {
        case let .basic(title):
            let cell = BasicTableViewCell.from(tableView)
            cell.textLabel?.text = title
            return cell
        case let .rightDetail(title, subtitle):
            let cell = RightDetailTableViewCell.from(tableView)
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = subtitle
            return cell
        case let .leftDetail(title, subtitle):
            let cell = LeftDetailTableViewCell.from(tableView)
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = subtitle
            return cell
        case let .subtitle(title, subtitle):
            let cell = SubtitleTableViewCell.from(tableView)
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = subtitle
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section].items[indexPath.row] {
        case let .basic(title):
            print("did select basic cell:", title)
        case let .rightDetail(title, _):
            print("did select rightDetail:", title)
        case let .leftDetail(title, _):
            print("did select leftDetail:", title)
        case let .subtitle(title, _):
            print("did select subtitle:", title)

        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        sections[indexPath.section].items.remove(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section].items[indexPath.row] {
        case .basic:
            return 44
        case .rightDetail:
            return 44 * 1.5
        case .leftDetail:
            return 44 * 2
        case .subtitle:
            return 44 * 2.5
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section].identity {
        case .basicSection:
            return "Basic Section"
        case .rightDetailSection:
            return "Right Detail Section"
        case .leftDetailSection:
            return "Left Detail Section"
        case .subtitleSection:
            return "Subtitle Section"
        }
    }
    
}

extension TableViewController {
    /// For each section
    enum SectionStyle {
        case basicSection
        case rightDetailSection
        case leftDetailSection
        case subtitleSection
    }
    
    /// For each cell
    enum CellStyle {
        case basic(String)
        case rightDetail(title: String, subtitle: String)
        case leftDetail(title: String, subtitle: String)
        case subtitle(title: String, subtitle: String)
    }
}

