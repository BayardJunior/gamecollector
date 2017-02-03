//
//  GameViewController.swift
//  GameCollector
//
//  Created by Bayard Junior on 02/02/17.
//  Copyright © 2017 Bayard Junior. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNaTabela(_ sender: Any) {
        //pega o contexto
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //cria a entidade
        let game = Game(context: context)
        
        //atribuiçao
        game.text = descricao.text
        game.image = UIImagePNGRepresentation(image.image!) as NSData!
        
        //salva o contexto
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //tras a tela anterior
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func galeria(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        //apresenta uma nova ViewController
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //img => o que eu escolhi do grid de imagens
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //atribui a imagem para o outlet de imagem da tela
        image.image = img
        
        //dispensa uma ViewController
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: Any) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
