//
//  MoviesTableViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 04/09/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalJSON()
        
        tableView.estimatedRowHeight = 106
        
        //a altura das linhas da minha tela possuem uma dimensao automatica
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadLocalJSON() {
        
        //le o arquivo json no bundle principal e devolve o caminho para esse arquivo no projeto
        if let jsonURL = Bundle.main.url(forResource: "movies", withExtension: "json") {
            
            //o try eh pq o metodo devolve uma excessao
            
            //tenho o arquivo bruto, preciso converte-lo em json
            let data = try! Data(contentsOf: jsonURL)
            
            //me devolve um obj json a partir de um DATA, e falo o tipo que ele retorna
            //que nesse caso eh um array de dicionario e trato assim ==> as! [[String:Any]]
            let json =  try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String:Any]]
            
            for item in json {
                
                let title = item["title"] as! String
                let rating = item["rating"] as! Double
                let summary = item["summary"] as! String
                let duration = item["duration"] as! String
                let imageName = item["image_name"] as! String
                let categories = item["categories"] as! [String]
                let movie = Movie(title: title, rating: rating, summary: summary, duration: duration, imageName: imageName)
                
                movie.categories = categories
                
                movies.append(movie)
                
                movies.sort ( by: {$1.rating > $0.rating})
                
                
            }
        }
    }
    
    //antes de chamar a segue, passa por aqui
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let vc = segue.destination as! MovieViewController
        
        
        let movie = movies[tableView.indexPathForSelectedRow!.row]
        
        //mandei para a outra tela o index selecionado
        vc.movie = movie
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //quando foi so uma sessao eu excluo, pois por padrao eh um
    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
    //    return 0
    //}

    ///esse metodo eh chamado
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selecionei esta celula de indice \(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //aumento o numero do "prototype cell e personalizo ele"
        //var identifier: String = indexPath.row == 2 ? "bannerCell": "cell"
        //reutiliza as celulas
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        
        let movie = movies[indexPath.row]
        
        
        //cell.textLabel?.text = movie.title
        //cell.detailTextLabel?.text = "⭐️\(movie.rating)/10"


        cell.ivPoster.image = UIImage(named: movie.imageSmall)
        cell.lbTitle.text = movie.title
        cell.lbSummary.text = movie.summary
        cell.lbRating.text = "⭐️ \(movie.rating)/10"
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
