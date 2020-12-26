//
//  ComicsListViewController.swift
//  hero.es
//
//  Created by Marivaldo Sena on 02/11/20.
//

import UIKit

class ComicsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let container = DBManager.shared.getContainer()
        let modelsArray = ComicHeroRelationshipCoreDataDAO(container: container).find(term: "agent")
        print(modelsArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let container = DBManager.shared.getContainer()
        let modelsArray = ComicHeroRelationshipCoreDataDAO(container: container).find(term: "iron")
        print(modelsArray)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
