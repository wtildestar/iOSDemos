//
//  PokedexController.swift
//  Pokedex
//
//  Created by wtildestar on 17/01/2020.
//  Copyright © 2020 wtildestar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PokedexCell"

class PokedexController: UICollectionViewController {
    
    // MARK: - Properties
    
    var pokemon = [PokemonModel]()
    var filteredPokemon = [PokemonModel]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
    var infoView: InfoView = {
       let view = InfoView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        fetchPokemon()
    }
    
    // MARK: - Selectors
    
    @objc func showSearchBar() {
        configureSearchBar(shouldShow: true)
    }
    
    @objc func handleDismissal() {
        dismissInfoView(pokemon: nil)
    }
    
    // MARK: - API
    
    func fetchPokemon() {
        Service.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func showPokemonInfoController(withPokemon pokemon: PokemonModel) {
        let controller = PokemonInfoController()
        controller.pokemon = pokemon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func configureSearchBar(shouldShow: Bool) {
        
        if shouldShow {
            searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
            searchBar.tintColor = .white
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            collectionView.reloadData()
        }
        
    }
    
    func dismissInfoView(pokemon: PokemonModel?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.infoView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            guard let pokemon = pokemon else { return }
            self.showPokemonInfoController(withPokemon: pokemon)
        }
    }
    
    // кнопка поиска
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func configureViewComponents() {
        collectionView.backgroundColor = .white
        
        navigationController?.navigationBar.barTintColor = .mainPink()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Pokedex"
        
        configureSearchBarButton()
        
        // Регистрация ячейки
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        visualEffectView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(gesture)
    }
    
}

// MARK: - Extensions

extension PokedexController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inSearchMode ? filteredPokemon.count : pokemon.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokedexCell
        
        cell.pokemon = inSearchMode ? filteredPokemon[indexPath.item] : pokemon[indexPath.item]
        
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = inSearchMode ? filteredPokemon[indexPath.item] : pokemon[indexPath.item]
        
        var pokemonEvoArray = [PokemonModel]()
        
        // имеется ли evolutuinChain в модели
        if let evoChain = poke.evolutionChain {
            // создал экземпляр EvolutionChain модели
            let evolutionChain = EvolutionChain(evolutionArray: evoChain)
            // нахожу evolutionIds в экземпляре модели EvolutionChain
            let evoIds = evolutionChain.evolutionIds
            // перебираю полученные evoIds с последнего
            evoIds.forEach { (id) in
                // вношу перебранные evoIds в массив
                pokemonEvoArray.append(pokemon[id - 1])
            }
            // передаю собранный массив в экземпляр модели evoArray
            poke.evoArray = pokemonEvoArray
        }
        // отображаю инфоконтроллер
        showPokemonInfoController(withPokemon: poke)
    }
}

extension PokedexController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
}

// поведение с SearchBar
extension PokedexController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearchBar(shouldShow: false)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
}

extension PokedexController: PokedexCellDelegate {
    func presentInfoView(withPokemon pokemon: PokemonModel) {
        configureSearchBar(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(infoView)
        infoView.configureViewComponents()
        infoView.delegate = self
        infoView.pokemon = pokemon
        infoView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width - 64, height: 350)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.infoView.alpha = 1
            self.infoView.transform = .identity
        }
    }
}

extension PokedexController: InfoViewDelegate {
    func dismissInfoView(withPokemon pokemon: PokemonModel?) {
        dismissInfoView(pokemon: pokemon)
    }
}


