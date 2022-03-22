//
//  PokeMonDetailViewController.swift
//  PokeMon
//
//  Created by Yansong Wang on 2022/3/22.
//

import UIKit

class PokeMonDetailViewController: UIViewController {

    var pokeMon: PokeMon?
    var detail: PokeMonDetail?
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelWeightHeight: UILabel!
    @IBOutlet weak var labelidExp: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitle()
        self.getDetail()
    }
    
    func setTitle() {
        let name = pokeMon?.name ?? "unknown"
        // Do any additional setup after loading the view.
        self.title = name
        
        self.imageView.setImage(url: self.pokeMon?.getImageURL(), duration: 0)
        
        self.labelName.text = "Name: \(name)"
    }
    
    func getDetail() {
        guard let url = pokeMon?.url else {
            return
        }
        PokeMonHandler.getDetail(url: url) { result in
            self.detail = result
            self.setDetail()
        } _: { errorMessage in
            
        }
    }
    
    func setDetail() {
        let height = detail?.height ?? 0
        let weight = detail?.weight ?? 0
        let id = detail?.id ?? 0
        let exp = detail?.exp ?? 0
        
        self.labelWeightHeight.text = "Height: \(height), Weight: \(weight)"
        self.labelidExp.text = "ID: \(id), EXP: \(exp)"
        
        self.tableView.reloadData()
    }
    
}

extension PokeMonDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.getSectionsCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.removeAllSubViews()
        
        let label = UILabel(frame: CGRect(x: 15, y: 5, width: self.view.frame.width - 20, height: 35))
        
        label.text = self.getNameForIndexPath(indexPath: indexPath)
        //label.font = UIFont(name: "PokemonSolidNormal", size: 13)
        label.font = UIFont.systemFont(ofSize: 13)
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.getTitleInSection(section: section)
    }
    
    func getSectionsCount() -> Int {
        if let _ = self.detail {
            return 9
        } else {
            return 0
        }
    }
    
    func getRowsInSection(section: Int) -> Int {
        if let detail = self.detail {
            switch (section) {
            case 0:
                return detail.getAbilites().count
            case 1:
                return detail.getForms().count
            case 2:
                return detail.getGameIndices().count
            case 3:
                return detail.getHeldItems().count
            case 4:
                return detail.getMoves().count
            case 5:
                return detail.getSpecies().count
            case 6:
                return detail.getSprites().count
            case 7:
                return detail.getStats().count
            case 8:
                return detail.getTypes().count
            default:
                break
            }
        }
        return 0
    }
    
    func getTitleInSection(section: Int) -> String {
        if let _ = self.detail {
            switch (section) {
            case 0:
                return "Abilities"
            case 1:
                return "Forms"
            case 2:
                return "Game Indices"
            case 3:
                return "Held Items"
            case 4:
                return "Moves"
            case 5:
                return "Species"
            case 6:
                return "Sprites"
            case 7:
                return "Stats"
            case 8:
                return "Types"
            default:
                break
            }
        }
        return "Unknown"
    }
    
    func getNameForIndexPath(indexPath: IndexPath) -> String {
        if let detail = self.detail {
            switch (indexPath.section) {
            case 0:
                return detail.getAbilites()[indexPath.row]
            case 1:
                return detail.getForms()[indexPath.row]
            case 2:
                return detail.getGameIndices()[indexPath.row]
            case 3:
                return detail.getHeldItems()[indexPath.row]
            case 4:
                return detail.getMoves()[indexPath.row]
            case 5:
                return detail.getSpecies()[indexPath.row]
            case 6:
                return detail.getSprites()[indexPath.row]
            case 7:
                return detail.getStats()[indexPath.row]
            case 8:
                return detail.getTypes()[indexPath.row]
            default:
                break
            }
        }
        return "Unknown"
    }
}

extension PokeMonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
