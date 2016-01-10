//
//  ViewController.swift
//  pokedex-by-devslopes
//
//  Created by Zafer Celaloglu on 9.01.2016.
//  Copyright © 2016 Zafer Celaloglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    var pokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        parsePokemonCSV()
    }

    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!

        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows

            for row in rows {

                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
        } catch let err as NSError {
            print(err)
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {

            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSizeMake(105, 105)
    }
}

