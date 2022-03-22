//
//  ViewController.swift
//  PokenMen
//
//  Created by Yansong Wang on 2022/3/22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var viewSplash: UIView!
    @IBOutlet weak var imageAnimatedLogo: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewControl: UIView!
    @IBOutlet weak var labelOffset: UILabel!
    
    
    let COUNT_LIMIT = 50
    var COUNT_OFFSET = 0
    var TOTAL_COUNT = 0

    var pokemons: [PokeMon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.setNavigationBar()
        
        self.setLogoAnimation()
        
        
        
        self.getPokemons()
    }
    
    func setLogoAnimation() {
        self.navigationItem.titleView?.isHidden = true
        var images: [UIImage] = []
        
        for i in 0...26 {
            if let image = UIImage(named: "logo_anim_\(i)") {
                images.append(image)
            } else if let image = UIImage(named: "logo_anim_0\(i)") {
                images.append(image)
            }
        }
        
        self.imageAnimatedLogo.animationImages = images
        self.imageAnimatedLogo.animationDuration = 3
        self.imageAnimatedLogo.animationRepeatCount = 1
        
        self.imageAnimatedLogo.startAnimating()
        
        Utils.setTimeout(4) {
            self.navigationItem.titleView?.isHidden = false
            self.viewSplash.isHidden = true
        }
    }
    
    func setNavigationBar() {
        
        // Set Navigation Images.
        
        let logo = UIImage(named: "ic_logo")
        
        let logoImageView = UIImageView(image: logo)
        
        self.navigationItem.titleView = logoImageView
        
        // Set Navigation Appearance.
        
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = COLOR_BLUE
        let attributes = [NSAttributedString.Key.font: UIFont(name: "PokemonSolidNormal", size: 24), NSAttributedString.Key.foregroundColor: COLOR_ORANGE]
        appearance.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.standardAppearance = appearance
            
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    func setControlView() {
        let limitIndex = self.COUNT_OFFSET / COUNT_LIMIT + 1
        
        if limitIndex < 10 {
            self.labelOffset.text = "0\(limitIndex)"
        } else {
            self.labelOffset.text = "\(limitIndex)"
        }
    }

    func getPokemons() {
        let urlString = API_LIST + "limit=\(COUNT_LIMIT)&offset=\(COUNT_OFFSET)"
        
        PokeMonHandler.getList(url: urlString) { results, count  in
            self.pokemons = results
            self.TOTAL_COUNT = count
            self.setControlView()
            self.tableView.reloadData()
        } _: { error in
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Actions.
    
    @IBAction func actionFirst(_ sender: Any) {
        if self.COUNT_OFFSET == 0 {
            return
        }
        self.COUNT_OFFSET = 0
        self.getPokemons()
    }
    
    @IBAction func actionLast(_ sender: Any) {
        if self.TOTAL_COUNT == 0 {
            return
        }
        
        let offset = self.TOTAL_COUNT - (self.TOTAL_COUNT % COUNT_LIMIT)
        
        if offset == self.COUNT_OFFSET {
            return
        }
        
        self.COUNT_OFFSET = offset
        
        self.getPokemons()
    }
    
    @IBAction func actionPrevious(_ sender: Any) {
        if self.COUNT_OFFSET == 0 {
            return
        }
        self.COUNT_OFFSET -= COUNT_LIMIT
        
        self.getPokemons()
    }
    
    @IBAction func actionNext(_ sender: Any) {
        let offset = self.COUNT_OFFSET + COUNT_LIMIT
        
        if offset > self.TOTAL_COUNT {
            return
        }
        
        self.COUNT_OFFSET = offset
        
        self.getPokemons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ID_DETAIL, let destination = segue.destination as? PokeMonDetailViewController, let index = self.tableView.indexPathForSelectedRow?.row {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            destination.pokeMon = self.pokemons[index]
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        let pokeMon = self.pokemons[indexPath.row]
        
        cell.contentView.removeAllSubViews()
        
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
        imageView.setImage(url: pokeMon.getImageURL(), duration: 0)
        
        cell.contentView.addSubview(imageView)
        
        let titleLabel = UILabel(frame: CGRect(x: 60, y: 10, width: self.view.frame.width, height: 40))
        
        titleLabel.text = pokeMon.name ?? "unknown"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        cell.contentView.addSubview(titleLabel)        
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Utils.setTimeout(0.3) {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

