//
//  GameViewController.swift
//  golf_n_friends_client
//
//  Created by Luke Poppe on 6/2/16.
//  Copyright © 2016 Luke Poppe. All rights reserved.
//

import UIKit

protocol GameViewControllerDelegate : class {
    func didCreateGame(game: Game)
}

class GameViewController: UITableViewController {
    
    @IBOutlet weak var gameTitleTextField: UITextField!
    var game : Game?
    
    weak var delegate : GameViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func createGamePressed(sender: AnyObject) {
        guard let title = self.gameTitleTextField.text,
        game = self.game else {
            return
        }
        game.title = title
        self.delegate?.didCreateGame(game)
    }
}
