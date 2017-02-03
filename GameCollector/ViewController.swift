//
//  ViewController.swift
//  GameCollector
//
//  Created by Bayard Junior on 02/02/17.
//  Copyright © 2017 Bayard Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var games : [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //pega o contexto
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            //retorna tudo o que for game do coredata
            games = try context.fetch(Game.fetchRequest())
            //atualiza a tabela
            tableView.reloadData()
        }catch {
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //retorna a quantidade de itens para a tabela
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cria uma celula
        let cell = UITableViewCell()
        //atribui o que tiver detro de games[x] para a celula
        cell.textLabel?.text = games[indexPath.row].text!
        
        //atribui o que tiver detro de games[x] para a celula
        //conversao de NSData para UIImage
        cell.imageView?.image = UIImage(data: games[indexPath.row].image! as Data)
        
        //retona a celula com as informaçeos
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

