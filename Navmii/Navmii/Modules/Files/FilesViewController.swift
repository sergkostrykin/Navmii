//
//  FilesViewController.swift
//  Navmii
//
//  Created by Sergiy Kostrykin on 19/10/2022.
//

import UIKit

class FilesViewController: UIViewController {
    
    // MARK: - Properties
    private var onFileSelected: ((String)->())?
    private var files = [String]()
    
    // MARK: - UI
    private lazy var trackListTitleLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .colorBlack
        label.text = "Saved Tracks"
        return label
    }()

    private lazy var tableView: UITableView = {
        var table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.register(cells: ["FileTableViewCell"])
        return table
    }()

    // MARK: - Methods
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(onFileSelected: ((String)->())?) {
        self.onFileSelected = onFileSelected
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filesRequest()
    }
}

private extension FilesViewController {
    func buildUI() {
        view.backgroundColor = .white
        view.addSubview(trackListTitleLabel)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            trackListTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            trackListTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
            trackListTitleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            trackListTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: trackListTitleLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showFile(file: String) {
        onFileSelected?(file)
    }
    
    // MARK: - Requests
    func filesRequest() {
        files = Bundle.main.paths(forResourcesOfType: "gpx", inDirectory: nil)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FilesViewController: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        files.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
                
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let file = files[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileTableViewCell", for: indexPath) as! FileTableViewCell
        cell.setup(file: file)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = files[indexPath.row]
        showFile(file: file)
    }

}
