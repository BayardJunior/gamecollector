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
    
    @IBOutlet weak var deleteBt: UIButton!
    @IBOutlet weak var addUpdateBt: UIButton!
    
    
    var game: Game? = nil
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //
        if(game != nil){
            
                        //atribuiçao do titulo do jogo
            descricao.text = game!.text
            //cnvertendo NSDate(CoreData) pra imageview
            image.image = UIImage(data: game!.image as! Data)
            //setando o butao para update
            addUpdateBt.setTitle("Update", for: .normal)
        }else{
            deleteBt.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addNaTabela(_ sender: Any) {
        
        if game != nil {

            //atribuiçao
            game!.text = descricao.text
            game!.image = UIImagePNGRepresentation(image.image!) as NSData!

            
        }else{
            
            //pega o contexto
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            //cria a entidade
            let game = Game(context: context)
            
            //atribuiçao
            game.text = descricao.text
            game.image = UIImagePNGRepresentation(image.image!) as NSData!
            
        }
        
        //salva o contexto
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //tras a tela anterior
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deletaJogo(_ sender: Any) {
        //pega o contexto da aplicação
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //deletar a informaçao do coredata
        context.delete(game!)
        
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
        
        //pega a camera do iPhone
        imagePicker.sourceType = .camera
        
        //apresenta em uma nova viewvontroller
        present(imagePicker, animated: true, completion: nil)
        
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
